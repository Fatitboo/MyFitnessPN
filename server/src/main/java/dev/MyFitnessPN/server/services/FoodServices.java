package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.meal.Food;
import dev.MyFitnessPN.server.component.meal.Meal;
import dev.MyFitnessPN.server.component.meal.Recipe;
import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FoodServices {
    private final UserRepository userRepository;

    public List<Food> getAllFoodOfUser(String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();

        List<Food> foods = user.getFoods();

        if (foods == null) foods = new ArrayList<>();


        return foods;
    }

    public List<Recipe> getAllRecipesOfUser(String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();

        List<Recipe> r = user.getRecipes();

        if (r == null) r = new ArrayList<>();


        return r;
    }

    public List<Meal> getAllMealsOfUser(String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();

        List<Meal> m = user.getMeals();

        if (m == null) m = new ArrayList<>();


        return m;
    }

    public Food createFood(Food foodDto, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();

        List<Food> foods = user.getFoods();
        foodDto.setFoodId(UUID.randomUUID().toString());
        if (foods == null) foods = new ArrayList<>();
        foods.add(foodDto);

        user.setFoods(foods);

        userRepository.save(user);

        return foodDto;
    }

    public void updateFood(Food foodDto, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();
        if (foodDto.getFoodId().isEmpty()) {
            throw new DataIntegrityViolationException("Food id is not exist!");
        }

        List<Food> foods = user.getFoods();

        if (foods == null) foods = new ArrayList<>();
        for (Food f : foods) {
            if (f.getFoodId().equals(foodDto.getFoodId())) {
                foods.set(foods.indexOf(f), foodDto);
                break;
            }
        }

        user.setFoods(foods);

        userRepository.save(user);
    }

    public void deleteFood(String foodId, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();


        List<Food> foods = user.getFoods();

        if (foods == null) foods = new ArrayList<>();
        for (Food f : foods) {
            if (f.getFoodId().equals(foodId)) {
                foods.remove(f);
                break;
            }
        }

        user.setFoods(foods);

        userRepository.save(user);
    }

    public Recipe createRecipe(Recipe recipeDto, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();

        List<Recipe> recipes = user.getRecipes();
        recipeDto.setRecipeId(UUID.randomUUID().toString());
        if (recipes == null) recipes = new ArrayList<>();
        if(recipes.stream().noneMatch(recipe -> recipe.getTitle().equals(recipeDto.getTitle()))){
            recipes.add(recipeDto);
        }
        user.setRecipes(recipes);

        userRepository.save(user);

        return recipeDto;
    }

    public void updateRecipe(Recipe RecipeDto, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();
        if (RecipeDto.getRecipeId().isEmpty()) {
            throw new DataIntegrityViolationException("Recipe id is not exist!");
        }

        List<Recipe> recipes = user.getRecipes();

        if (recipes == null) recipes = new ArrayList<>();
        for (Recipe r : recipes) {
            if (r.getRecipeId().equals(RecipeDto.getRecipeId())) {
                recipes.set(recipes.indexOf(r), RecipeDto);
                break;
            }
        }

        user.setRecipes(recipes);

        userRepository.save(user);
    }

    public void deleteRecipe(String RecipeId, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();


        List<Recipe> recipes = user.getRecipes();
        if (recipes == null) recipes = new ArrayList<>();
        for (Recipe r : recipes) {
            if (r.getRecipeId().equals(RecipeId)) {
                recipes.remove(r);
                break;
            }
        }

        user.setRecipes(recipes);

        userRepository.save(user);
    }

    public Meal createMeal(Meal MealDto, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();

        List<Meal> meals = user.getMeals();
        MealDto.setMealId(UUID.randomUUID().toString());
        if (meals == null) meals = new ArrayList<>();
        if(meals.stream().noneMatch(meal -> meal.getDescription().equals(MealDto.getDescription()))){
            meals.add(MealDto);
        }

        user.setMeals(meals);

        userRepository.save(user);

        return MealDto;
    }

    public void updateMeal(Meal mealDto, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();
        if (mealDto.getMealId().isEmpty()) {
            throw new DataIntegrityViolationException("Meal id is not exist!");
        }

        List<Meal> meals = user.getMeals();

        if (meals == null) meals = new ArrayList<>();
        for (Meal r : meals) {
            if (r.getMealId().equals(mealDto.getMealId())) {
                meals.set(meals.indexOf(r), mealDto);
                break;
            }
        }

        user.setMeals(meals);

        userRepository.save(user);
    }

    public void deleteMeal(String mealId, String userId) {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();


        List<Meal> meals = user.getMeals();
        if (meals == null) meals = new ArrayList<>();
        for (Meal r : meals) {
            if (r.getMealId().equals(mealId)) {
                meals.remove(r);
                break;
            }
        }

        user.setMeals(meals);

        userRepository.save(user);
    }
}
