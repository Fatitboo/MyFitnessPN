package dev.MyFitnessPN.server.controllers;

import dev.MyFitnessPN.server.component.exercise.Exercise;
import dev.MyFitnessPN.server.component.exercise.Routine;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.ExerciseDTO;
import dev.MyFitnessPN.server.dtos.RoutineDTO;
import dev.MyFitnessPN.server.services.ExerciseService;
import dev.MyFitnessPN.server.services.RoutineService;
import dev.MyFitnessPN.server.value.Constant;
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
@RequestMapping("api/v1/user/routines")
@RequiredArgsConstructor
public class RoutineController {
    private final RoutineService routineService;

    @GetMapping("/{userId}")
    public ResponseEntity<?> getAllRoutine(@PathVariable String userId) {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            List<Routine> routines = routineService.getAllRoutine(userId);
            return ResponseEntity.status(HttpStatus.OK).body(routines);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("{userId}/create-routine")
    public ResponseEntity<?> createRoutine(@Valid @RequestBody RoutineDTO routineDTO, @PathVariable String userId, BindingResult result) {

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
            Routine exercise = routineService.createRoutine(routineDTO, userId);
            return ResponseEntity.status(HttpStatus.CREATED).body(exercise);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PutMapping("{userId}/update-routine/{routineId}")
    public ResponseEntity<?> updateRoutine(@Valid @RequestBody RoutineDTO routineDTO, @PathVariable String userId, @PathVariable String routineId, BindingResult result) {

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
            res = routineService.updateExercise(routineDTO, userId, routineId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                        Response.put("routineId", routineId);
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
//
    @DeleteMapping("{userId}/delete-routine/{routineId}")
    public ResponseEntity<?> deleteExercise(@PathVariable String userId, @PathVariable String routineId){
        HashMap<String, Object> Response = new HashMap<>();
        try {
            MessageResponse res;
            res = routineService.deleteRoutine(userId, routineId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("routineId", routineId);
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
