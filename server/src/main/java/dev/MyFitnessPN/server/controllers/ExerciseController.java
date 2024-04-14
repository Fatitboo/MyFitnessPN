package dev.MyFitnessPN.server.controllers;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.ExerciseDTO;
import dev.MyFitnessPN.server.component.exercise.Exercise;
import dev.MyFitnessPN.server.models.ExerciseModel;
import dev.MyFitnessPN.server.services.ExerciseService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import dev.MyFitnessPN.server.value.Constant;

import java.util.HashMap;
import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("api/v1/user/exercises")
@RequiredArgsConstructor
public class ExerciseController {
    private final ExerciseService exerciseService;

    @GetMapping("/{userId}")
    public ResponseEntity<?> getAllExercise(@PathVariable String userId, @RequestParam(value="type", required = false) String type) {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            if(type == null){
                type = "none";
            }
            List<Exercise> exercise = exerciseService.getAllExercise(userId, type);
            return ResponseEntity.status(HttpStatus.OK).body(exercise);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("{userId}/create-exercise")
    public ResponseEntity<?> createExercise(@Valid @RequestBody ExerciseDTO exerciseDTO, @PathVariable String userId, BindingResult result) {

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
            Exercise exercise = exerciseService.createExercise(exerciseDTO, userId);
            return ResponseEntity.status(HttpStatus.CREATED).body(exercise);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PutMapping("{userId}/update-exercise/{exerciseId}")
    public ResponseEntity<?> updateExercise(@Valid @RequestBody ExerciseDTO exerciseDTO, @PathVariable String userId, @PathVariable String exerciseId, BindingResult result) {

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
            MessageResponse res;
            res = exerciseService.updateExercise(exerciseDTO, userId, exerciseId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("exerciseId", exerciseId);
                    Response.put("messageResponse", res.getResMessage());
                    return ResponseEntity.status(HttpStatus.OK).body(Response);
                default:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("System Failure!");
            }
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @DeleteMapping("{userId}/delete-exercise/{exerciseId}")
    public ResponseEntity<?> deleteExercise(@PathVariable String userId, @PathVariable String exerciseId){
        HashMap<String, Object> Response = new HashMap<>();
        try {
            MessageResponse res;
            res = exerciseService.deleteExercise(userId, exerciseId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("exerciseId", exerciseId);
                    Response.put("messageResponse", res.getResMessage());
                    return ResponseEntity.status(HttpStatus.OK).body(Response);
                default:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("System Failure!");
            }
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @GetMapping("/admin")
    public ResponseEntity<?> getAllExerciseAdmin() {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            List<ExerciseModel> exercise = exerciseService.getAllExerciseAdmin();
            return ResponseEntity.status(HttpStatus.OK).body(exercise);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("{userId}/create-exercise-admin")
    public ResponseEntity<?> createExerciseAdmin(@Valid @RequestBody ExerciseDTO exerciseDTO, @PathVariable String userId, BindingResult result) {

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
            ExerciseModel exercise = exerciseService.createExerciseAdmin(exerciseDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(exercise);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PutMapping("/update-exercise-admin/{exerciseId}")
    public ResponseEntity<?> updateExerciseAdmin(@Valid @RequestBody ExerciseDTO exerciseDTO, @PathVariable String exerciseId, BindingResult result) {

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
            MessageResponse res;
            res = exerciseService.updateExerciseAdmin(exerciseDTO, exerciseId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("exerciseId", exerciseId);
                    Response.put("messageResponse", res.getResMessage());
                    return ResponseEntity.status(HttpStatus.OK).body(Response);
                default:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("System Failure!");
            }
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @DeleteMapping("/delete-exercise-admin/{exerciseId}")
    public ResponseEntity<?> deleteExerciseAdmin(@PathVariable String exerciseId){
        HashMap<String, Object> Response = new HashMap<>();
        try {
            MessageResponse res;
            res = exerciseService.deleteExerciseAdmin(exerciseId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("exerciseId", exerciseId);
                    Response.put("messageResponse", res.getResMessage());
                    return ResponseEntity.status(HttpStatus.OK).body(Response);
                default:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("System Failure!");
            }
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

}

