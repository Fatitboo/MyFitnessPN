package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.RoutineCategoryDTO;
import dev.MyFitnessPN.server.models.RoutineCategory;
import dev.MyFitnessPN.server.repositories.RoutineCategoryRepository;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RoutineCategoryService {
    private final RoutineCategoryRepository routineCategoryRepository;
    public List<RoutineCategory> getAllRoutineCategory() throws Exception {
        return routineCategoryRepository.findAll();
    }
    public RoutineCategoryDTO createRoutineCategory(RoutineCategoryDTO routineCategoryDTO) throws Exception {
        //create new exercise
        RoutineCategory routineCategory = RoutineCategory.builder()
                .name(routineCategoryDTO.getName())
                .description(routineCategoryDTO.getDescription()).build();

        routineCategory.setRoutCategoryId(routineCategoryRepository.save(routineCategory).getRoutineCategoryId().toString());
        routineCategoryRepository.save(routineCategory);
        routineCategoryDTO.setRoutCategoryId(routineCategory.getRoutCategoryId());
        return routineCategoryDTO;
    }
    public MessageResponse updateRoutineCategory(RoutineCategoryDTO routineCategoryDTO, String routineCategoryId) throws Exception {
         //check type
        MessageResponse res = new MessageResponse();

        Optional<RoutineCategory> routineCategoryOptional = routineCategoryRepository.findById(new ObjectId(routineCategoryId));
        if(routineCategoryOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get category in database");
            return res;
        }

        RoutineCategory routineCategory = routineCategoryOptional.get();
        routineCategory.setName(routineCategoryDTO.getName());
        routineCategory.setDescription(routineCategoryDTO.getDescription());

        routineCategoryRepository.save(routineCategory);

        res.makeRes(Constant.MessageType.success, "Update routine category successfully!");
        return res;
    }
    public MessageResponse deleteRoutineCategory(String routineCategoryId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<RoutineCategory> routineCategoryOptional = routineCategoryRepository.findById(new ObjectId(routineCategoryId));
        if(routineCategoryOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get category in database");
            return res;
        }

        routineCategoryRepository.deleteById(routineCategoryOptional.get().getRoutineCategoryId());

        res.makeRes(Constant.MessageType.success, "Delete routine category successfully!");
        return res;
    }
}
