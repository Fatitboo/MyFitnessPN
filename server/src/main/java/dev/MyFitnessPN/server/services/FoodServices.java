package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.Food;
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

    public Food createFood(Food foodDto, String userId){
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();

        List<Food> foods = user.getFoods();
        foodDto.setFoodId(UUID.randomUUID().toString());
        if(foods==null) foods = new ArrayList<>();
        foods.add(foodDto);

        user.setFoods(foods);

        userRepository.save(user);

        return foodDto;
    }
    public void updateFood(Food foodDto, String userId){
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();
        if (foodDto.getFoodId().isEmpty()) {
            throw new DataIntegrityViolationException("Food id is not exist!");
        }

        List<Food> foods = user.getFoods();

        if(foods==null) foods = new ArrayList<>();
        for(Food f : foods){
            if(f.getFoodId().equals(foodDto.getFoodId())){
                foods.set(foods.indexOf(f), foodDto);
                break;
            }
        }

        user.setFoods(foods);

        userRepository.save(user);
    }
    public void deleteFood(String foodId, String userId){
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();


        List<Food> foods = user.getFoods();

        if(foods==null) foods = new ArrayList<>();
        for(Food f : foods){
            if(f.getFoodId().equals(foodId)){
                foods.remove(f);
                break;
            }
        }

        user.setFoods(foods);

        userRepository.save(user);
    }
}
