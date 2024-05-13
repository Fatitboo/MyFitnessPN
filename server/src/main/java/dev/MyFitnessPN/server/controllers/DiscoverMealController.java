package dev.MyFitnessPN.server.controllers;

import dev.MyFitnessPN.server.component.meal.Meal;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.models.MealModel;
import dev.MyFitnessPN.server.services.DiscoverMealService;
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
@RequestMapping("api/v1/meal")
@RequiredArgsConstructor
public class DiscoverMealController {
    private final DiscoverMealService discoverMealService;

    @GetMapping("")
    public ResponseEntity<?> getAllDiscoverMeals() {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            List<MealModel> meals = discoverMealService.getAllMealModel();
            return ResponseEntity.status(HttpStatus.OK).body(meals);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PostMapping("/create-discover-meal")
    public ResponseEntity<?> createDiscoverMeal(@Valid @RequestBody Meal meal, BindingResult result) {

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
            MealModel m = discoverMealService.createMealModel(meal);

            return ResponseEntity.status(HttpStatus.OK).body(m);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }

    @PutMapping("/update-discover-meal/{mealId}")
    public ResponseEntity<?> updateExerciseAdmin(@Valid @RequestBody Meal meal, @PathVariable String mealId, BindingResult result) {

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
            res = discoverMealService.updateMealModel(meal, mealId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning -> {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                }
                case Constant.MessageType.success -> {
                    Response.put("mealId", mealId);
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

    @DeleteMapping("/delete-discover-meal/{mealId}")
    public ResponseEntity<?> deleteDiscoverMeal(@PathVariable String mealId) {
        HashMap<String, Object> Response = new HashMap<>();
        try {
            MessageResponse res;
            res = discoverMealService.deleteMealModel(mealId);
            switch (res.getResType()) {
                case Constant.MessageType.error, Constant.MessageType.warning -> {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(res.getResMessage());
                }
                case Constant.MessageType.success -> {
                    Response.put("mealId", mealId);
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
