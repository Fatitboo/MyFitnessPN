package dev.MyFitnessPN.server.services;

import com.google.gson.Gson;
import dev.MyFitnessPN.server.component.indexBody.HealthDataResponse;
import dev.MyFitnessPN.server.component.JwtTokenUtils;
import dev.MyFitnessPN.server.component.plan.SubTask;
import dev.MyFitnessPN.server.component.plan.Task;
import dev.MyFitnessPN.server.dtos.UserDTO;
import dev.MyFitnessPN.server.dtos.UserLoginDTO;

import dev.MyFitnessPN.server.models.Plan;
import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.models.UserHealth;
import dev.MyFitnessPN.server.repositories.PlanRepository;
import dev.MyFitnessPN.server.repositories.UserHealthRepository;
import dev.MyFitnessPN.server.repositories.UserRepository;
import dev.MyFitnessPN.server.response.UserResponseLogin;
import dev.MyFitnessPN.server.value.Constant;
import dev.MyFitnessPN.server.value.EmailService;
import lombok.RequiredArgsConstructor;
import okhttp3.*;
import org.bson.types.ObjectId;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.Year;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.Random;


@Service
@RequiredArgsConstructor
public class UserServices {
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final PlanRepository planRepository;
    private final AuthenticationManager authenticationManager;
    private final JwtTokenUtils jwtTokenUtils;
    private final UserHealthRepository userHealthRepository;
    private final EmailService emailService;

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
        HashMap<String, String> obj = new HashMap<>();
        obj.put("height", String.valueOf(userDTO.getHeight()));
        obj.put("weight", String.valueOf(userDTO.getWeight()));
        obj.put("age", String.valueOf(age));
        obj.put("gender", String.valueOf(userDTO.getGender()));
        obj.put("exercise", String.valueOf(userDTO.getExercise()));
        obj.put("neck", String.valueOf(41));
        obj.put("hip", String.valueOf(100));
        obj.put("waist", String.valueOf(88));
        obj.put("goal", String.valueOf(userDTO.getGoal()));
        obj.put("deficit", String.valueOf(500));
        obj.put("goalWeight", String.valueOf(userDTO.getGoalWeight()));

//        String example = "height=190&weight=80&age=30&gender=male&exercise=little&neck=41&hip=100&waist=88&goal=maintenance&deficit=500&goalWeight=85";
//        String example2 = "{\"height\":\""+"190\",\"weight\":\"80\",\"age\":\"30\",\"gender\":\"male\",\"exercise\":\"little\",\"neck\":\"41\",\"hip\":\"100\",\"waist\":\"88\",\"goal\":\"maintenance\",\"deficit\":\"500\",\"goalWeight\":\"85\"}"

        MediaType mediaType = MediaType.parse("application/json");
        Gson gson = new Gson();
        String json = gson.toJson(obj);
        RequestBody body = RequestBody.create(mediaType, json);
        Request request = new Request.Builder()
                .url("https://fitness-api.p.rapidapi.com/fitness")
                .post(body)
                .addHeader("x-rapidapi-key", "3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf")
                .addHeader("x-rapidapi-host", "fitness-api.p.rapidapi.com")
                .addHeader("Content-Type", "application/json")
                .build();

        // Send api create userHealth -> save db

        OkHttpClient client = new OkHttpClient();

        Response response = client.newCall(request).execute();
        assert response.body() != null;
        HealthDataResponse healthDataResponse = gson.fromJson(response.body().string(), HealthDataResponse.class);
//        System.out.print(response.body().string());
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
                .waterIntake(healthDataResponse.getWeight() * Constant.WATER_INTAKE)
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
    public boolean updateUser(UserDTO userDTO) throws Exception {

        Optional<User> optionalUser = userRepository.findByUsername(userDTO.getUsername());
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User exitedUser = optionalUser.get();

        // call request calculate body index
        int age = Year.now().getValue() - userDTO.getDayOfBirth().getYear();
        HashMap<String, String> obj = new HashMap<>();
        obj.put("height", String.valueOf(userDTO.getHeight()));
        obj.put("weight", String.valueOf(userDTO.getWeight()));
        obj.put("age", String.valueOf(age));
        obj.put("gender", String.valueOf(userDTO.getGender()));
        obj.put("exercise", String.valueOf(userDTO.getExercise()));
        obj.put("neck", String.valueOf(41));
        obj.put("hip", String.valueOf(100));
        obj.put("waist", String.valueOf(88));
        obj.put("goal", String.valueOf(userDTO.getGoal()));
        obj.put("deficit", String.valueOf(500));
        obj.put("goalWeight", String.valueOf(userDTO.getGoalWeight()));

//        String example = "height=190&weight=80&age=30&gender=male&exercise=little&neck=41&hip=100&waist=88&goal=maintenance&deficit=500&goalWeight=85";
//        String example2 = "{\"height\":\""+"190\",\"weight\":\"80\",\"age\":\"30\",\"gender\":\"male\",\"exercise\":\"little\",\"neck\":\"41\",\"hip\":\"100\",\"waist\":\"88\",\"goal\":\"maintenance\",\"deficit\":\"500\",\"goalWeight\":\"85\"}"

        MediaType mediaType = MediaType.parse("application/json");
        Gson gson = new Gson();
        String json = gson.toJson(obj);
        RequestBody body = RequestBody.create(mediaType, json);
        Request request = new Request.Builder()
                .url("https://fitness-api.p.rapidapi.com/fitness")
                .post(body)
                .addHeader("x-rapidapi-key", "3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf")
                .addHeader("x-rapidapi-host", "fitness-api.p.rapidapi.com")
                .addHeader("Content-Type", "application/json")
                .build();

        // Send api create userHealth -> save db

        OkHttpClient client = new OkHttpClient();

        Response response = client.newCall(request).execute();
        assert response.body() != null;
        HealthDataResponse healthDataResponse = gson.fromJson(response.body().string(), HealthDataResponse.class);
//        System.out.print(response.body().string());
        // Transfer response data to entity data
        Optional<UserHealth> optionalUserH = userHealthRepository.findByUserId(String.valueOf(exitedUser.getUserId()));
        if (optionalUserH.isEmpty()) {
            throw new DataIntegrityViolationException("User health is not exist!");
        }
        UserHealth userHealth = optionalUserH.get();


        userHealth.setHeight(healthDataResponse.getHeight());
        userHealth.setWeight(healthDataResponse.getWeight());
        userHealth.setAge(healthDataResponse.getAge());
        userHealth.setGender(healthDataResponse.getGender());
        userHealth.setExercise(healthDataResponse.getExercise());
        userHealth.setGoal(healthDataResponse.getGoal());
        userHealth.setGoalWeight(healthDataResponse.getGoalWeight());
        userHealth.setBodyMassIndex(healthDataResponse.getBodyMassIndex());
        userHealth.setBodyFatPercentage(healthDataResponse.getBodyFatPercentage());
        userHealth.setLeanBodyMass(healthDataResponse.getLeanBodyMass());
        userHealth.setWaterIntake(healthDataResponse.getWeight() * Constant.WATER_INTAKE);
        userHealth.setRestingDailyEnergyExpenditure(healthDataResponse.getRestingDailyEnergyExpenditure());
        userHealth.setBasalMetabolicRate(healthDataResponse.getBasalMetabolicRate());
        userHealth.setTotalDailyEnergyExpenditure(healthDataResponse.getTotalDailyEnergyExpenditure());
        userHealth.setIdealBodyWeight(healthDataResponse.getIdealBodyWeight());
        // save user healthy in db
        userHealthRepository.save(userHealth);
        return true;
    }

    public boolean sendEmailReset(String username) throws IOException {

        Optional<User> optionalUser = userRepository.findByUsername(username);
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User exitedUser = optionalUser.get();

        try {
            Random random = new Random();
            StringBuilder sb = new StringBuilder(4);
            for (int i = 0; i < 4; i++) {
                sb.append(random.nextInt(10));
            }
            String randomString = sb.toString();
            exitedUser.setTokenResetPassword(randomString);
            LocalDateTime now = LocalDateTime.now();
            // Thêm 10 phút
            LocalDateTime newDateTime = now.plusMinutes(10);
            exitedUser.setExpiredDateTokenResetPassword(newDateTime);
            userRepository.save(exitedUser);

            emailService.sendSingleResetPasswordEmail(exitedUser.getEmail(), "Reset password", randomString);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public boolean checkOtp(String username, String otp) throws IOException {
        Optional<User> optionalUser = userRepository.findByUsername(username);
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User exitedUser = optionalUser.get();
        if (!exitedUser.getTokenResetPassword().equals(otp)) {
            throw new DataIntegrityViolationException("Otp not correct!");
        }
        if (exitedUser.getExpiredDateTokenResetPassword().isBefore(LocalDateTime.now())) {
            throw new DataIntegrityViolationException("Otp was expired!");
        }

        return true;
    }

    public boolean resetPassword(String username, String password) throws IOException {
        Optional<User> optionalUser = userRepository.findByUsername(username);
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User exitedUser = optionalUser.get();

        exitedUser.setTokenResetPassword(null);
        exitedUser.setExpiredDateTokenResetPassword(null);

        String encodedPassword = passwordEncoder.encode(password);
        exitedUser.setPassword(encodedPassword);
        userRepository.save(exitedUser);

        return true;
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
        } else {
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
                .fullName(user.getUsername())
                .userType(user.getUserType())
                .email(user.getEmail())
                .dob(user.getDayOfBirth())
                .token(token)
                .build();
    }

    public void updatePassword(String id, String oldPass, String newPass) {
        Optional<User> foundUser = userRepository.findById(new ObjectId(id));
        if (foundUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = foundUser.get();
        if (user.getGoogleAccountId() == 0) {
            if (!passwordEncoder.matches(oldPass, user.getPassword())) {
                throw new BadCredentialsException("Password not correct!");
            }
        }
        String encodedPassword = passwordEncoder.encode(newPass);
        user.setPassword(encodedPassword);
        userRepository.save(user);
    }

    public HealthDataResponse getUserHealthData(String id) {
        Optional<UserHealth> userHealth = userHealthRepository.findByUserId(id);
        if (userHealth.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        UserHealth healthDataResponse = userHealth.get();
        return HealthDataResponse.builder()
                .height(healthDataResponse.getHeight())
                .weight(healthDataResponse.getWeight())
                .age(healthDataResponse.getAge())
                .gender(healthDataResponse.getGender())
                .exercise(healthDataResponse.getExercise())
                .goal(healthDataResponse.getGoal())
                .goalWeight(healthDataResponse.getGoalWeight())
                .waterIntake(healthDataResponse.getWaterIntake())
                .bodyMassIndex(healthDataResponse.getBodyMassIndex())
                .bodyFatPercentage(healthDataResponse.getBodyFatPercentage())
                .leanBodyMass(healthDataResponse.getLeanBodyMass())
                .restingDailyEnergyExpenditure(healthDataResponse.getRestingDailyEnergyExpenditure())
                .basalMetabolicRate(healthDataResponse.getBasalMetabolicRate())
                .totalDailyEnergyExpenditure(healthDataResponse.getTotalDailyEnergyExpenditure())
                .idealBodyWeight(healthDataResponse.getIdealBodyWeight())
                .build();
    }

    public void setupPlan(String userId, String planId) {
        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if (userOptional.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        Optional<Plan> planOptional = planRepository.findById(new ObjectId(planId));
        if (planOptional.isEmpty()) {
            throw new DataIntegrityViolationException("Cannot find plan in database");
        }
        User user = userOptional.get();
        Plan plan = planOptional.get();


        user.setPlan(plan.getTaskList());
        user.setDateStartPlan(LocalDateTime.now());

        userRepository.save(user);
    }

    public void maskDoneSubTask(String userId, String planId, int index) {
        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if (userOptional.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        Optional<Plan> planOptional = planRepository.findById(new ObjectId(planId));
        if (planOptional.isEmpty()) {
            throw new DataIntegrityViolationException("Cannot find plan in database");
        }
        User user = userOptional.get();
        List<Task> taskList = user.getPlan();

//        SubTask subTask = taskList.get;
        LocalDateTime currentDate = LocalDateTime.now();

        long length = ChronoUnit.HOURS.between(user.getDateStartPlan(), currentDate) / 24;
        Task task = taskList.get(Integer.parseInt(String.valueOf(length)));

        List<SubTask> subTaskList = task.getSubTaskList();
        SubTask subTask = subTaskList.get(index);
        subTask.setFinish(!subTask.isFinish());

        user.setPlan(taskList);

        userRepository.save(user);
    }
}
