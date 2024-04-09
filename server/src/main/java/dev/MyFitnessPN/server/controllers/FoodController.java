package dev.MyFitnessPN.server.controllers;

import dev.MyFitnessPN.server.component.Food;
import dev.MyFitnessPN.server.services.FoodServices;
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
@RequestMapping("api/v1/foods")
@RequiredArgsConstructor
public class FoodController {
    private final FoodServices foodServices;
    @PostMapping("/{userId}/createFood")
    public ResponseEntity<?> createFood(@PathVariable String userId,@RequestBody Food foodDto,  BindingResult result) {

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
            Food f = foodServices.createFood(foodDto, userId);


            Response.put("message","Add food successfully!");
            Response.put("addedFood",f);

            return ResponseEntity.status(HttpStatus.CREATED).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @PostMapping("/{userId}/updateFood")
    public ResponseEntity<?> updateFood( @RequestBody Food foodDto, @PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            foodServices.updateFood(foodDto, userId);
            Response.put("message","Update food successfully!");
            Response.put("updatedFood",foodDto);

            return ResponseEntity.status(HttpStatus.CREATED).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @DeleteMapping("/{userId}/deleteFood/{fooId}")
    public ResponseEntity<?> deleteFood( @PathVariable String fooId, @PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            foodServices.deleteFood(fooId, userId);
            Response.put("message","Delete food successfully!");
            Response.put("deletedFoodId",fooId);

            return ResponseEntity.status(HttpStatus.CREATED).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
}
