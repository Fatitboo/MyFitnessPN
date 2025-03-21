package dev.MyFitnessPN.server.controllers;

import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.component.plan.Task;
import dev.MyFitnessPN.server.dtos.ExerciseDTO;
import dev.MyFitnessPN.server.dtos.PlanDTO;
import dev.MyFitnessPN.server.models.ExerciseModel;
import dev.MyFitnessPN.server.models.Plan;
import dev.MyFitnessPN.server.services.PlanService;
import dev.MyFitnessPN.server.services.UserServices;
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
@RequestMapping("api/v1/plan")
@RequiredArgsConstructor
public class PlanController {
    private final PlanService planService;
    private final UserServices userServices;

    @GetMapping("")
    public ResponseEntity<?> getAllPlans() {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            List<Plan> exercise = planService.getAllPlan();
            return ResponseEntity.status(HttpStatus.OK).body(exercise);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("/create-plan")
    public ResponseEntity<?> createPlan(@Valid @RequestBody PlanDTO planDTO, BindingResult result) {

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
            Plan plan = planService.createPlan(planDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(plan);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PutMapping("/update-plan/{planId}")
    public ResponseEntity<?> updateExerciseAdmin(@Valid @RequestBody PlanDTO planDTO, @PathVariable String planId, BindingResult result) {

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
            res = planService.updatePlan(planDTO, planId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("planId", planId);
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

    @PutMapping("/update-plan-tasks/{planId}")
    public ResponseEntity<?> updatePlanTasks(@Valid @RequestBody List<Task> tasks, @PathVariable String planId, BindingResult result) {
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
            res = planService.updateTasks(tasks, planId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("planId", planId);
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


    @DeleteMapping("/delete-plan/{planId}")
    public ResponseEntity<?> deletePlan(@PathVariable String planId){
        HashMap<String, Object> Response = new HashMap<>();
        try {
            MessageResponse res;
            res = planService.deletePlan(planId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("planId", planId);
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
