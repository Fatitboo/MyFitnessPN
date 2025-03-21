package dev.MyFitnessPN.server.controllers;

import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.MealCategoryDTO;
import dev.MyFitnessPN.server.models.MealCategory;
import dev.MyFitnessPN.server.services.MealCategoryService;
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
@RequestMapping("api/v1/admin/meal-categories")
@RequiredArgsConstructor
public class MealCategoryController {
    private final MealCategoryService mealCategoryService;

    @GetMapping("")
    public ResponseEntity<?> getAllMealCategory() {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            List<MealCategory> exercise = mealCategoryService.getAllMealCategory();
            return ResponseEntity.status(HttpStatus.OK).body(exercise);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("/create-meal-category")
    public ResponseEntity<?> createMealCategory(@Valid @RequestBody MealCategoryDTO MealCategoryDTO, BindingResult result) {

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
            MealCategoryDTO MealCategory = mealCategoryService.createMealCategory(MealCategoryDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(MealCategory);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PutMapping("/update-meal-category/{MealCategoryId}")
    public ResponseEntity<?> updateMealCategory(@Valid @RequestBody MealCategoryDTO MealCategoryDTO, @PathVariable String MealCategoryId, BindingResult result) {

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
            res = mealCategoryService.updateMealCategory(MealCategoryDTO, MealCategoryId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning -> {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                }
                case Constant.MessageType.success -> {
                    Response.put("MealCategoryId", MealCategoryId);
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

    @DeleteMapping("/delete-meal-category/{MealCategoryId}")
    public ResponseEntity<?> deleteMealCategory(@PathVariable String MealCategoryId) {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            MessageResponse res;
            res = mealCategoryService.deleteMealCategory(MealCategoryId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning -> {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                }
                case Constant.MessageType.success -> {
                    Response.put("MealCategoryId", MealCategoryId);
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
