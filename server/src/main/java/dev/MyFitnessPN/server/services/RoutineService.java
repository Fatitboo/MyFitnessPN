package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.exercise.Exercise;
import dev.MyFitnessPN.server.component.exercise.Routine;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.RoutineDTO;
import dev.MyFitnessPN.server.models.RoutineModel;
import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.repositories.RoutineRepository;
import dev.MyFitnessPN.server.repositories.UserRepository;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RoutineService {
    private final UserRepository userRepository;
    private final RoutineRepository routineRepository;
    public List<Routine> getAllRoutine(String userId) throws Exception {
        //check type
        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            throw new DataIntegrityViolationException("Error when get user in database");
        }
        User user = userOptional.get();
        return user.getRoutines();
    }
    public List<RoutineModel> getSeveralRoutine(List<String> routineIds) throws Exception{
        List<ObjectId> ids = (List)routineIds;
        Iterable<ObjectId> a = ids;
        Optional<List<RoutineModel>> routineModels = Optional.of(routineRepository.findAllById(a));
        if(routineModels.isEmpty()){
            throw new DataIntegrityViolationException("Error when get routine in database");
        }

        return routineModels.get();
    }
    public RoutineDTO createRoutine(RoutineDTO routineDTO, String userId) throws Exception {
        //check type
        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            throw new DataIntegrityViolationException("Error when get user in database");
        }

        //create new routine
        Routine routine = Routine.builder()
                .routineId(new ObjectId())
                .routineName(routineDTO.getRoutineName())
                .description(routineDTO.getDescription())
                .plannedVolume(routineDTO.getPlannedVolume())
                .duration(routineDTO.getDuration())
                .caloriesBurned(routineDTO.getCaloriesBurned())
                .exercises(routineDTO.getExercises()).build();

        routine.setRoutId(routine.getRoutineId().toString());

        //add routine to user
        User user = userOptional.get();

        List<Routine> routineList;

        if(user.getRoutines() == null || user.getRoutines().isEmpty()){
            routineList = new ArrayList<>();
        }
        else{
            routineList = user.getRoutines();
        }

        routineList.add(routine);

        user.setRoutines(routineList);

        userRepository.save(user);

        routineDTO.setRoutId(routine.getRoutineId().toString());
        return routineDTO;
    }
    public MessageResponse updateRoutine(RoutineDTO routineDTO, String userId, String routineId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get user in database");
            return res;
        }

        User user = userOptional.get();

        List<Routine> routineList = user.getRoutines();

        if(user.getRoutines() == null || user.getRoutines().isEmpty()){
            res.makeRes(Constant.MessageType.warning, "This user don't have any routine in database");
            return res;
        }

        for(int i = 0; i < routineList.size(); i++){
            if(routineList.get(i).getRoutineId().toString().equals(routineId)){
                Routine routine = Routine.builder()
                        .routineId(routineList.get(i).getRoutineId())
                        .routId(routineId)
                        .routineName(routineDTO.getRoutineName())
                        .description(routineDTO.getDescription())
                        .plannedVolume(routineDTO.getPlannedVolume())
                        .duration(routineDTO.getDuration())
                        .caloriesBurned(routineDTO.getCaloriesBurned())
                        .exercises(routineDTO.getExercises()).build();
                routineList.set(i, routine);
                user.setRoutines(routineList);
                userRepository.save(user);
                res.makeRes(Constant.MessageType.success, "Update routine user successfully!");
                return res;
            }
        }

        res.makeRes(Constant.MessageType.warning, "Don't have this routine in user");
        return res;
    }
    public MessageResponse deleteRoutine(String userId, String routineId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get user in database");
            return res;
        }

        User user = userOptional.get();

        List<Routine> routineList = user.getRoutines();

        if(routineList == null || routineList.isEmpty()){
            res.makeRes(Constant.MessageType.warning, "This user don't have any routine in database");
            return res;
        }

        for(int i = 0; i < routineList.size(); i++){
            if(routineList.get(i).getRoutineId().toString().equals(routineId)){
                routineList.remove(i);
                user.setRoutines(routineList);
                userRepository.save(user);
                res.makeRes(Constant.MessageType.success, "Delete routine user successfully!");
                return res;
            }
        }

        res.makeRes(Constant.MessageType.warning, "Don't have this routine in user");
        return res;
    }

    //admin
    public List<RoutineModel> getAllRoutineAdmin() throws Exception {
        return routineRepository.findAll();
    }
    public RoutineDTO createRoutineAdmin(RoutineDTO routineDTO) throws Exception {
        //create new routine
        RoutineModel routine = RoutineModel.builder()
                .routineName(routineDTO.getRoutineName())
                .category(routineDTO.getCategory())
                .duration(routineDTO.getDuration())
                .type(routineDTO.getType())
                .category(routineDTO.getCategory())
                .workoutOverview(routineDTO.getWorkoutOverview())
                .video(routineDTO.getVideo())
                .thumbNail(routineDTO.getThumbNail())
                .description(routineDTO.getDescription())
                .exercises(routineDTO.getExercises()).build();

        routineDTO.setRoutId(routineRepository.save(routine).getRoutineId().toString());
        routine.setRoutId(routineDTO.getRoutId());
        routineRepository.save(routine);
        return routineDTO;
    }
//    public MessageResponse updateExerciseAdmin(Routine routineDTO, String routineId) throws Exception {
//        //check type
//        MessageResponse res = new MessageResponse();
//
//        Optional<RoutineModel> routineModelOptional = routineRepository.findById(new ObjectId(routineId));
//        if(routineModelOptional.isEmpty()){
//            res.makeRes(Constant.MessageType.error, "Error when get routine in database");
//            return res;
//        }
//
//        RoutineModel routineModel = routineModelOptional.get();
//        routineModel.setCategory(routineDTO.getCategory());
//        routineModel.setVideo(routineDTO.getVideo());
//        routineModel.setDuration(routineDTO.getDuration());
//        routineModel.setType(routineDTO.getType());
//        routineModel.setRoutineName(routineDTO.getRoutineName());
//        routineModel.setDescription(routineDTO.getDescription());
//        routineModel.setExercises(routineDTO.getExercises());
//
//        routineRepository.save(routineModel);
//        res.makeRes(Constant.MessageType.success, "Update routine successfully");
//        return res;
//    }
//    public MessageResponse deleteRoutineAdmin(String routineId) throws Exception {
//        //check type
//        MessageResponse res = new MessageResponse();
//
//        Optional<RoutineModel> routineOptional = routineRepository.findById(new ObjectId(routineId));
//        if(routineOptional.isEmpty()){
//            res.makeRes(Constant.MessageType.error, "Error when get routine in database");
//            return res;
//        }
//
//        RoutineModel routineModel = routineOptional.get();
//
//        routineRepository.deleteById(routineModel.getRoutineId());
//
//        res.makeRes(Constant.MessageType.success, "Delete routine successfully!");
//        return res;
//    }

}
