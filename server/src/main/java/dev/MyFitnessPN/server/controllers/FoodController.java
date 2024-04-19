package dev.MyFitnessPN.server.controllers;

import dev.MyFitnessPN.server.component.meal.Food;
import dev.MyFitnessPN.server.component.meal.Meal;
import dev.MyFitnessPN.server.component.meal.Recipe;
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
    @GetMapping("/{userId}/getFood")
    public ResponseEntity<?> getAllFoodbyUserId(@PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            List<Food> f = foodServices.getAllFoodOfUser( userId);


            Response.put("message","Get all foods successfully!");
            Response.put("foods",f);

            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @GetMapping("/{userId}/getRecipes")
    public ResponseEntity<?> getAllRecipesbyUserId(@PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            List<Recipe> r = foodServices.getAllRecipesOfUser( userId);


            Response.put("message","Get all recipes successfully!");
            Response.put("recipes",r);

            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @GetMapping("/{userId}/getMeals")
    public ResponseEntity<?> getAllMealsbyUserId(@PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            List<Meal> m = foodServices.getAllMealsOfUser( userId);


            Response.put("message","Get all meals successfully!");
            Response.put("meals",m);

            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
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

            return ResponseEntity.status(HttpStatus.OK).body(Response);
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

            return ResponseEntity.status(HttpStatus.OK).body(Response);
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

            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @PostMapping("/{userId}/createRecipe")
    public ResponseEntity<?> createRecipe(@PathVariable String userId,@RequestBody Recipe recipeDto) {

        HashMap<String, Object> Response = new HashMap<>();

        try {


            Recipe recipe = foodServices.createRecipe(recipeDto, userId);
            Response.put("message","Add recipe successfully!");
            Response.put("addedRecipe",recipe);

            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @PostMapping("/{userId}/updateRecipe")
    public ResponseEntity<?> updateRecipe( @RequestBody Recipe recipeDto, @PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            foodServices.updateRecipe(recipeDto,userId);
            Response.put("message","Update Recipe successfully!");
            Response.put("updatedRecipe",recipeDto);

            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @DeleteMapping("/{userId}/deleteRecipe/{recipeId}")
    public ResponseEntity<?> deleteRecipe( @PathVariable String recipeId, @PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            foodServices.deleteRecipe(recipeId,userId);
            Response.put("message","Delete Recipe successfully!");
            Response.put("deletedRecipeId",recipeId);
            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @PostMapping("/{userId}/createMeal")
    public ResponseEntity<?> createMeal(@PathVariable String userId,@RequestBody Meal mealDto) {

        HashMap<String, Object> Response = new HashMap<>();

        try {


            Meal meal = foodServices.createMeal(mealDto, userId);
            Response.put("message","Add Meal successfully!");
            Response.put("addedMeal",meal);

            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @PostMapping("/{userId}/updateMeal")
    public ResponseEntity<?> updateMeal( @RequestBody Meal mealDto, @PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            foodServices.updateMeal(mealDto,userId);
            Response.put("message","Update Meal successfully!");
            Response.put("updatedMeal",mealDto);

            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
    @DeleteMapping("/{userId}/deleteMeal/{mealId}")
    public ResponseEntity<?> deleteMeal( @PathVariable String mealId, @PathVariable String userId) {

        HashMap<String, Object> Response = new HashMap<>();

        try {
            foodServices.deleteMeal(mealId,userId);
            Response.put("message","Delete Meal successfully!");
            Response.put("deletedMealId",mealId);
            return ResponseEntity.status(HttpStatus.OK).body(Response);
        } catch (Exception e) {
            Response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Response);
        }
    }
}
