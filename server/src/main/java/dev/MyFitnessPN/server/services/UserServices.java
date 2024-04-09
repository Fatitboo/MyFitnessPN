package dev.MyFitnessPN.server.services;

import com.google.gson.Gson;
import dev.MyFitnessPN.server.component.HealthDataResponse;
import dev.MyFitnessPN.server.component.JwtTokenUtils;
import dev.MyFitnessPN.server.dtos.UserDTO;
import dev.MyFitnessPN.server.dtos.UserLoginDTO;

import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.models.UserHealth;
import dev.MyFitnessPN.server.repositories.UserHealthRepository;
import dev.MyFitnessPN.server.repositories.UserRepository;
import dev.MyFitnessPN.server.response.UserResponseLogin;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import okhttp3.*;
import org.bson.types.ObjectId;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Year;
import java.util.Optional;



@Service
@RequiredArgsConstructor
public class UserServices {
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final AuthenticationManager authenticationManager;
    private final JwtTokenUtils jwtTokenUtils;
    private final UserHealthRepository userHealthRepository;
    public UserResponseLogin createUser(UserDTO userDTO) throws Exception {
        // check password
        if (!userDTO.getPassword().equals(userDTO.getCPassword())) {
            throw new Exception("Confirm password have to match password");
        }

        // check username existed
        if (userRepository.existsByUsername(userDTO.getUsername())) {
            throw new DataIntegrityViolationException("Username already exists");
        }

        // create new account
        User newAcc = User.builder()
                .username(userDTO.getUsername())
                .fullName(userDTO.getFullName())
                .email(userDTO.getEmail())
                .dayOfBirth(userDTO.getDayOfBirth())
                .userType("user")
                .googleAccountId(userDTO.getGoogleAccountId())
                .build();

        String password = userDTO.getPassword();
        String encodedPassword = passwordEncoder.encode(password);
        newAcc.setPassword(encodedPassword);

        // save new account
        User user = userRepository.save(newAcc);

        // call request calculate body index
        int age = Year.now().getValue() - userDTO.getDayOfBirth().getYear();
        String requestBody =  "height=" + userDTO.getHeight()
                + "&weight=" + userDTO.getWeight()
                + "&age=" + age
                + "&gender=" + userDTO.getGender()
                + "&exercise=" + userDTO.getExercise()
                + "&neck=41&hip=100&waist=88"
                + "&goal=" + userDTO.getGoal()
                + "&deficit=500"
                + "&goalWeight=" + userDTO.getGoalWeight();
        String example = "height=190&weight=80&age=30&gender=male&exercise=little&neck=41&hip=100&waist=88&goal=maintenance&deficit=500&goalWeight=85";

        MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
        Gson gson = new Gson();
        RequestBody body = RequestBody.create(mediaType, requestBody);
        Request request = new Request.Builder()
                .url("https://fitness-api.p.rapidapi.com/fitness")
                .post(body)
                .addHeader("content-type", "application/x-www-form-urlencoded")
                .addHeader("X-RapidAPI-Key", "3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf")
                .addHeader("X-RapidAPI-Host", "fitness-api.p.rapidapi.com")
                .build();

        // Send api create userHealth -> save db

        OkHttpClient client = new OkHttpClient();

        Response response = client.newCall(request).execute();
        assert response.body() != null;
        HealthDataResponse healthDataResponse = gson.fromJson(response.body().string(), HealthDataResponse.class);

        // Transfer response data to entity data
        UserHealth userHealth = UserHealth.builder()
                .userId(String.valueOf(user.getUserId()))
                .height(healthDataResponse.getHeight())
                .weight(healthDataResponse.getWeight())
                .age(healthDataResponse.getAge())
                .gender(healthDataResponse.getGender())
                .exercise(healthDataResponse.getExercise())
                .goal(healthDataResponse.getGoal())
                .goalWeight(healthDataResponse.getGoalWeight())
                .bodyMassIndex(healthDataResponse.getBodyMassIndex())
                .bodyFatPercentage(healthDataResponse.getBodyFatPercentage())
                .leanBodyMass(healthDataResponse.getLeanBodyMass())
                .waterIntake(healthDataResponse.getWeight()* Constant.WATER_INTAKE)
                .restingDailyEnergyExpenditure(healthDataResponse.getRestingDailyEnergyExpenditure())
                .basalMetabolicRate(healthDataResponse.getBasalMetabolicRate())
                .totalDailyEnergyExpenditure(healthDataResponse.getTotalDailyEnergyExpenditure())
                .idealBodyWeight(healthDataResponse.getIdealBodyWeight())
                .build();

       // save user healthy in db
        userHealthRepository.save(userHealth);



        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                userDTO.getUsername(), userDTO.getPassword(),
                user.getAuthorities()
        );

        //authenticate with Java Spring security
        authenticationManager.authenticate(authenticationToken);
        String token = jwtTokenUtils.generateToken(user);

        // return info with jwt token
        return UserResponseLogin.builder()
                .userId(user.getUserId().toString())
                .fullName(user.getFullName())
                .userType(user.getUserType())
                .email(user.getEmail())
                .token(token)
                .build();



    }
    public UserResponseLogin login(UserLoginDTO userLoginDTO) throws Exception {
        Optional<User> optionalUser = userRepository.findByUsername(userLoginDTO.getUsername());
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();

        //check password
        if (user.getGoogleAccountId() == 0) {
            if (!passwordEncoder.matches(userLoginDTO.getPassword(), user.getPassword())) {
                throw new BadCredentialsException("Username or password is not correct!");
            }
        }
        else{
            if (user.getGoogleAccountId() != userLoginDTO.getGoogleAccountId()) {
                throw new BadCredentialsException("Username or password is not correct!");
            }
        }
        if (!userLoginDTO.getUserType().equals(user.getUserType())) {
            throw new BadCredentialsException("Username or password is not correct!");
        }


        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                userLoginDTO.getUsername(), userLoginDTO.getPassword(),
                user.getAuthorities()
        );

        //authenticate with Java Spring security
        authenticationManager.authenticate(authenticationToken);
        String token = jwtTokenUtils.generateToken(user);

        return UserResponseLogin.builder()
                .userId(user.getUserId().toString())
                .fullName(user.getFullName())
                .userType(user.getUserType())
                .email(user.getEmail())
                .token(token)
                .build();
    }

    public void updatePassword(String id, String oldPass, String newPass){
        Optional<User> foundUser = userRepository.findById(new ObjectId(id));
        if(foundUser.isEmpty()){
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = foundUser.get();
        if (user.getGoogleAccountId() == 0) {
            if(!passwordEncoder.matches(oldPass, user.getPassword())) {
                throw new BadCredentialsException("Password not correct!");
            }
        }
        String encodedPassword = passwordEncoder.encode(newPass);
        user.setPassword(encodedPassword);
        userRepository.save(user);
    }
    public HealthDataResponse getUserHealthData(String id){
        Optional<UserHealth> userHealth = userHealthRepository.findByUserId(id);
        if(userHealth.isEmpty()){
            throw new DataIntegrityViolationException("User is not exist!");
        }
        UserHealth healthDataResponse = userHealth.get();
        return  HealthDataResponse.builder()
                .height(healthDataResponse.getHeight())
                .weight(healthDataResponse.getWeight())
                .age(healthDataResponse.getAge())
                .gender(healthDataResponse.getGender())
                .exercise(healthDataResponse.getExercise())
                .goal(healthDataResponse.getGoal())
                .goalWeight(healthDataResponse.getGoalWeight())
                .bodyMassIndex(healthDataResponse.getBodyMassIndex())
                .bodyFatPercentage(healthDataResponse.getBodyFatPercentage())
                .leanBodyMass(healthDataResponse.getLeanBodyMass())
                .restingDailyEnergyExpenditure(healthDataResponse.getRestingDailyEnergyExpenditure())
                .basalMetabolicRate(healthDataResponse.getBasalMetabolicRate())
                .totalDailyEnergyExpenditure(healthDataResponse.getTotalDailyEnergyExpenditure())
                .idealBodyWeight(healthDataResponse.getIdealBodyWeight())
                .build();
    }

}
