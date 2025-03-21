package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.MealCategoryDTO;
import dev.MyFitnessPN.server.models.MealCategory;
import dev.MyFitnessPN.server.repositories.MealCategoryRepository;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MealCategoryService {
    private final MealCategoryRepository mealCategoryRepository;
    public List<MealCategory> getAllMealCategory() throws Exception {
        return mealCategoryRepository.findAll();
    }
    public MealCategoryDTO createMealCategory(MealCategoryDTO MealCategoryDTO) throws Exception {
        //create new exercise
        MealCategory MealCategory = dev.MyFitnessPN.server.models.MealCategory.builder()
                .name(MealCategoryDTO.getName())
                .description(MealCategoryDTO.getDescription()).build();


        mealCategoryRepository.save(MealCategory);
        MealCategoryDTO.setMealCategoryId(MealCategory.getMealCategoryId().toString());
        return MealCategoryDTO;
    }
    public MessageResponse updateMealCategory(MealCategoryDTO MealCategoryDTO, String MealCategoryId) throws Exception {
         //check type
        MessageResponse res = new MessageResponse();

        Optional<MealCategory> MealCategoryOptional = mealCategoryRepository.findById(new ObjectId(MealCategoryId));
        if(MealCategoryOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get category in database");
            return res;
        }

        MealCategory MealCategory = MealCategoryOptional.get();
        MealCategory.setName(MealCategoryDTO.getName());
        MealCategory.setDescription(MealCategoryDTO.getDescription());

        mealCategoryRepository.save(MealCategory);

        res.makeRes(Constant.MessageType.success, "Update meal category successfully!");
        return res;
    }
    public MessageResponse deleteMealCategory(String MealCategoryId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<MealCategory> MealCategoryOptional = mealCategoryRepository.findById(new ObjectId(MealCategoryId));
        if(MealCategoryOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get category in database");
            return res;
        }

        mealCategoryRepository.deleteById(MealCategoryOptional.get().getMealCategoryId());

        res.makeRes(Constant.MessageType.success, "Delete meal category successfully!");
        return res;
    }
}
