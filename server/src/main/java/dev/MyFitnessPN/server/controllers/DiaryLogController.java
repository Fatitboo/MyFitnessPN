package dev.MyFitnessPN.server.controllers;

import dev.MyFitnessPN.server.component.indexBody.HealthDataResponse;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.LogDiaryDTO;
import dev.MyFitnessPN.server.dtos.UserDTO;
import dev.MyFitnessPN.server.dtos.UserLoginDTO;
import dev.MyFitnessPN.server.models.LogDiaryItem;
import dev.MyFitnessPN.server.models.Plan;
import dev.MyFitnessPN.server.response.UserResponseLogin;
import dev.MyFitnessPN.server.services.LogDiaryService;
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
@RequestMapping("api/v1/log-diary")
@RequiredArgsConstructor
public class DiaryLogController {
    private final LogDiaryService logDiaryService;
    @GetMapping("/{userId}/{logDate}")
    public ResponseEntity<?> getAllDiaryLogByDate(
            @PathVariable String userId,
            @PathVariable String logDate
    ) {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            List<LogDiaryItem> logDiaryItems = logDiaryService.getAllLogDiaryInDate(logDate, userId);
            return ResponseEntity.status(HttpStatus.OK).body(logDiaryItems);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @PostMapping("/add-log/{userId}")
    public ResponseEntity<?> addLogDiaryDate(@Valid @RequestBody LogDiaryDTO logDiaryDTO,
                                             BindingResult result, @PathVariable String userId) {

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
            LogDiaryDTO l = logDiaryService.addLogDiary(logDiaryDTO, userId);
            return ResponseEntity.status(HttpStatus.OK).body(l);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("/update-diary/{userId}")
    public ResponseEntity<?> updateLogDiaryDate(
            @Valid @RequestBody LogDiaryDTO logDiaryDTO,
            BindingResult result, @PathVariable String userId

    ) {
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
            MessageResponse res = logDiaryService.updateDiaryLog(logDiaryDTO, userId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning -> {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                }
                case Constant.MessageType.success -> {
                    Response.put("logDiaryItemId", logDiaryDTO.getLogDiaryId());
                    Response.put("messageResponse", res.getResMessage());
                    return ResponseEntity.status(HttpStatus.OK).body(Response);
                }
                default -> {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("System Failure!");
                }
            }
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @DeleteMapping("/delete-diary/{userId}/{logDate}/{logDiaryItemId}")
    public ResponseEntity<?> deleteLogDiaryDate(
            @PathVariable String userId,
            @PathVariable String logDate,
            @PathVariable String logDiaryItemId
    ) {
        HashMap<String, Object> Response = new HashMap<>();

        try {
            MessageResponse res = logDiaryService.deleteDiaryLog(logDiaryItemId, userId, logDate);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning -> {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                }
                case Constant.MessageType.success -> {
                    Response.put("logDiaryItemId", logDiaryItemId);
                    Response.put("messageResponse", res.getResMessage());
                    return ResponseEntity.status(HttpStatus.OK).body(Response);
                }
                default -> {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("System Failure!");
                }
            }
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

}