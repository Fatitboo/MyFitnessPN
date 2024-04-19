package dev.MyFitnessPN.server.controllers;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.RoutineCategoryDTO;
import dev.MyFitnessPN.server.models.RoutineCategory;
import dev.MyFitnessPN.server.services.RoutineCategoryService;
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
@RequestMapping("api/v1/admin/routine-categories")
@RequiredArgsConstructor
public class RoutineCategoryController {
    private final RoutineCategoryService routineCategoryService;
    @GetMapping("")
    public ResponseEntity<?> getAllExercise() {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            List<RoutineCategory> exercise = routineCategoryService.getAllRoutineCategory();
            return ResponseEntity.status(HttpStatus.OK).body(exercise);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("/create-routine-category")
    public ResponseEntity<?> createRoutineCategory(@Valid @RequestBody RoutineCategoryDTO routineCategoryDTO, BindingResult result) {

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
            RoutineCategoryDTO routineCategory  = routineCategoryService.createRoutineCategory(routineCategoryDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(routineCategory);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PutMapping("/update-routine-category/{routineCategoryId}")
    public ResponseEntity<?> updateExercise(@Valid @RequestBody RoutineCategoryDTO routineCategoryDTO, @PathVariable String routineCategoryId,BindingResult result) {

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
            res = routineCategoryService.updateRoutineCategory(routineCategoryDTO, routineCategoryId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("routineCategoryId", routineCategoryId);
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

    @DeleteMapping("/delete-routine-category/{routineCategoryId}")
    public ResponseEntity<?> deleteExercise(@PathVariable String routineCategoryId){
        HashMap<String, Object> Response = new HashMap<>();
        try {
            MessageResponse res;
            res = routineCategoryService.deleteRoutineCategory(routineCategoryId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("routineCategoryId", routineCategoryId);
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
