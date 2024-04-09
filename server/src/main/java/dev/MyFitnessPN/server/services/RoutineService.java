package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.exercise.Exercise;
import dev.MyFitnessPN.server.component.exercise.Routine;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.RoutineDTO;
import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.repositories.UserRepository;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RoutineService {
    private final UserRepository userRepository;
    public List<Routine> getAllRoutine(String userId) throws Exception {
        //check type
        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            throw new DataIntegrityViolationException("Error when get user in database");
        }
        User user = userOptional.get();

        return user.getRoutines();
    }
    public Routine createRoutine(RoutineDTO routineDTO, String userId) throws Exception {
        //check type
        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            throw new DataIntegrityViolationException("Error when get user in database");
        }

        //create new routine
        Routine routine = Routine.builder()
                .routineId(new ObjectId(new java.util.Date()))
                .routineName(routineDTO.getRoutineName())
                .description(routineDTO.getDescription())
                .plannedVolume(routineDTO.getPlannedVolume())
                .duration(routineDTO.getDuration())
                .caloriesBurned(routineDTO.getCaloriesBurned())
                .exercises(routineDTO.getExercises()).build();

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

        return routine;
    }

    public MessageResponse updateExercise(RoutineDTO routineDTO, String userId, String routineId) throws Exception {
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
                        .routineId(new ObjectId(new java.util.Date()))
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

}
