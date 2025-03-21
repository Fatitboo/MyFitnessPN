package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.meal.Meal;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;

import dev.MyFitnessPN.server.models.MealModel;
import dev.MyFitnessPN.server.repositories.MealRepository;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DiscoverMealService {

    private final MealRepository mealRepository;

    public List<MealModel> getAllMealModel() throws Exception {
        return mealRepository.findAll();
    }

    public MealModel createMealModel(Meal MealModelDTO) throws Exception {
        MealModel m = MealModel.builder()
                .description(MealModelDTO.getDescription())
                .photo(MealModelDTO.getPhoto())
                .mealType(MealModelDTO.getMealType())
                .numberOfServing(MealModelDTO.getNumberOfServing())
                .recipes(Arrays.stream(MealModelDTO.getRecipes()).toList())
                .foods(Arrays.stream(MealModelDTO.getFoods()).toList())
                .direction(MealModelDTO.getDirection())
                .build();
        m.getRecipes().forEach(r->{
            r.setRecipeId(UUID.randomUUID().toString());
        });
        m.getFoods().forEach(f->{
            f.setFoodId(UUID.randomUUID().toString());
        });
        return mealRepository.save(m);
    }

    public MessageResponse updateMealModel(Meal MealModelDTO, String MealModelId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<MealModel> MealModelOptional = mealRepository.findById(new ObjectId(MealModelId));
        if (MealModelOptional.isEmpty()) {
            res.makeRes(Constant.MessageType.error, "Error when get Meal Model in database");
            return res;
        }

        MealModel m = MealModelOptional.get();
        m.setDescription(MealModelDTO.getDescription());
        m.setPhoto(MealModelDTO.getPhoto());
        m.setMealType(MealModelDTO.getMealType());
        m.setNumberOfServing(MealModelDTO.getNumberOfServing());
        m.setRecipes(Arrays.stream(MealModelDTO.getRecipes()).toList());
        m.setFoods(Arrays.stream(MealModelDTO.getFoods()).toList());
        m.setDirection(MealModelDTO.getDirection());

        res.makeRes(Constant.MessageType.success, "Update Meal Model successfully!");
        mealRepository.save(m);
        return res;
    }

    public MessageResponse deleteMealModel(String MealModelId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<MealModel> MealModelOptional = mealRepository.findById(new ObjectId(MealModelId));
        if (MealModelOptional.isEmpty()) {
            res.makeRes(Constant.MessageType.error, "Error when find Meal Model in database");
            return res;
        }
        mealRepository.deleteById(MealModelOptional.get().getMealId());
        res.makeRes(Constant.MessageType.success, "Delete Meal Model successfully");
        return res;
    }

}
