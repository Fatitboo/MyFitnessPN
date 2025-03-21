package dev.MyFitnessPN.server.controllers;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.PlanTypeDTO;
import dev.MyFitnessPN.server.models.PlanType;
import dev.MyFitnessPN.server.services.PlanTypeService;
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
@RequestMapping("api/v1/admin/plan-types")
@RequiredArgsConstructor
public class PlanTypeController {

    private final PlanTypeService planTypeService;
    @GetMapping("")
    public ResponseEntity<?> getAllExercise() {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            List<PlanType> planTypes = planTypeService.getAllPlanType();
            return ResponseEntity.status(HttpStatus.OK).body(planTypes);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("/create-plan-type")
    public ResponseEntity<?> createPlanType(@Valid @RequestBody PlanTypeDTO planTypeDTO, BindingResult result) {

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
            PlanType planType  = planTypeService.createPlanType(planTypeDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(planType);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PutMapping("/update-plan-type/{planTypeId}")
    public ResponseEntity<?> updateExercise(@Valid @RequestBody PlanTypeDTO planTypeDTO, @PathVariable String planTypeId, BindingResult result) {

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
            res = planTypeService.updatePlanType(planTypeDTO, planTypeId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("planTypeId", planTypeId);
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

    @DeleteMapping("/delete-plan-type/{planTypeId}")
    public ResponseEntity<?> deleteExercise(@PathVariable String planTypeId){
        HashMap<String, Object> Response = new HashMap<>();
        try {
            MessageResponse res;
            res = planTypeService.deletePlanType(planTypeId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning:
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                case Constant.MessageType.success:
                    Response.put("planTypeId", planTypeId);
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
