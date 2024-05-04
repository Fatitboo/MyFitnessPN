package dev.MyFitnessPN.server.controllers;

import dev.MyFitnessPN.server.component.indexBody.HealthDataResponse;
import dev.MyFitnessPN.server.dtos.UserDTO;
import dev.MyFitnessPN.server.dtos.UserLoginDTO;
import dev.MyFitnessPN.server.response.UserResponseLogin;
import dev.MyFitnessPN.server.services.UserServices;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("api/v1/users")
@RequiredArgsConstructor
public class UserController {
    private final UserServices userServices;

    @PostMapping("/register")
    public ResponseEntity<?> createUser(@Valid @RequestBody UserDTO userDTO,
                                        BindingResult result) {

        HashMap<String, Object> Response = new HashMap<>();
        if (result.hasErrors()) {
            List<String> errMsgs = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            Response.put("message", errMsgs.toString());
            return ResponseEntity.badRequest().body(Response);
        }
        try {
            UserResponseLogin u = userServices.createUser(userDTO);
            return ResponseEntity.status(HttpStatus.OK).body(u);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(
            @Valid @RequestBody UserLoginDTO userLoginDTO,
            BindingResult result
    ) {
        // check login information and create token
        // return token response
        // this token is used to log in again if login
        HashMap<String, Object> loginResponse = new HashMap<>();

        if (result.hasErrors()) {
            List<String> errMsgs = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            loginResponse.put("message", errMsgs.toString());
            return ResponseEntity.badRequest().body(loginResponse);
        }
        try {
            UserResponseLogin user = userServices.login(userLoginDTO);
            loginResponse.put("message", "Login successfully!");
            loginResponse.put("user", user);
            return ResponseEntity.status(HttpStatus.OK).body(loginResponse);
        } catch (Exception e) {
            loginResponse.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(loginResponse);
        }
    }

    @GetMapping("/get_user_health/{id}")
    public ResponseEntity<?> getUserHealth(@PathVariable String id) {
        HashMap<String, Object> response = new HashMap<>();

        try {
            HealthDataResponse healthDataResponse = userServices.getUserHealthData(id);
            response.put("message", "Get user health successfully!");
            response.put("userHealth", healthDataResponse);
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (Exception e) {
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    @PutMapping("{userId}/set-up-plan/{planId}")
    public ResponseEntity<?> setupPlan(@PathVariable String userId, @PathVariable String planId){
        HashMap<String, Object> response = new HashMap<>();

        try {
            userServices.setupPlan(userId, planId);
            response.put("message", "Set up plan successfully!");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (Exception e) {
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }
    @PutMapping("/{userId}/mask-done-task/{planId}")
    public ResponseEntity<?> maskDoneSubTask(@PathVariable String userId, @PathVariable String planId,@RequestParam(value="index", required = true) int index){
        HashMap<String, Object> response = new HashMap<>();

        try {
            userServices.maskDoneSubTask(userId, planId, index);
            response.put("message", "Mask done sub task successfully!");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (Exception e) {
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }
}