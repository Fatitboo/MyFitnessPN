package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.ExerciseDTO;
import dev.MyFitnessPN.server.models.Exercise;
import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import dev.MyFitnessPN.server.value.Constant;
import java.util.*;


@Service
@RequiredArgsConstructor
public class ExerciseService {
    private final UserRepository userRepository;
    public List<Exercise> getAllExercise(String userId, String type) throws Exception {
        //check type
        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            throw new DataIntegrityViolationException("Error when get user in database");
        }
        User user = userOptional.get();

        return switch (type) {
            case Constant.ExerciseType.strength, Constant.ExerciseType.cardio ->
                    user.getExercises().stream().filter(item -> item.getType().equals(type)).toList();
            case "none" -> user.getExercises();
            default -> new ArrayList<>();
        };
    }
    public Exercise createExercise(ExerciseDTO exerciseDTO, String userId) throws Exception {
        //check type
        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            throw new DataIntegrityViolationException("Error when get user in database");
        }

        //create new exercise
        Exercise exercise = Exercise.builder()
                .exerciseId(new ObjectId(new java.util.Date()))
                .name(exerciseDTO.getName())
                .type(exerciseDTO.getType())
                .minutes(exerciseDTO.getMinutes())
                .caloriesBurn(exerciseDTO.getCaloriesBurn())
                .instruction(exerciseDTO.getInstruction())
                .video(exerciseDTO.getVideo())
                .sets(exerciseDTO.getSets()).build();

        //add exercise to user

        User user = userOptional.get();

        List<Exercise> exerciseList;

        if(user.getExercises() == null || user.getExercises().isEmpty()){
            exerciseList = new ArrayList<>();
        }
        else{
            exerciseList = user.getExercises();
        }

        exerciseList.add(exercise);

        user.setExercises(exerciseList);

        userRepository.save(user);

        return exercise;
    }

    public MessageResponse updateExercise(ExerciseDTO exerciseDTO, String userId, String exerciseId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get user in database");
            return res;
        }

        User user = userOptional.get();

        List<Exercise> exerciseList = user.getExercises();

        if(user.getExercises() == null || user.getExercises().isEmpty()){
            res.makeRes(Constant.MessageType.warning, "This user don't have any exercises in database");
            return res;
        }

        for(int i = 0; i < exerciseList.size(); i++){
            if(exerciseList.get(i).getExerciseId().toString().equals(exerciseId)){
                Exercise exercise = Exercise.builder()
                        .exerciseId(exerciseList.get(i).getExerciseId())
                        .name(exerciseDTO.getName())
                        .type(exerciseDTO.getType())
                        .minutes(exerciseDTO.getMinutes())
                        .caloriesBurn(exerciseDTO.getCaloriesBurn())
                        .instruction(exerciseDTO.getInstruction())
                        .video(exerciseDTO.getVideo())
                        .sets(exerciseDTO.getSets()).build();
                exerciseList.set(i, exercise);
                user.setExercises(exerciseList);
                userRepository.save(user);
                res.makeRes(Constant.MessageType.success, "Update exercise user successfully!");
                return res;
            }
        }

        res.makeRes(Constant.MessageType.warning, "Don't have this exercise in user");
        return res;
    }

    public MessageResponse deleteExercise(String userId, String exerciseId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<User> userOptional = userRepository.findById(new ObjectId(userId));
        if(userOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get user in database");
            return res;
        }

        User user = userOptional.get();

        List<Exercise> exerciseList = user.getExercises();

        if(user.getExercises() == null || user.getExercises().isEmpty()){
            res.makeRes(Constant.MessageType.warning, "This user don't have any exercises in database");
            return res;
        }

        for(int i = 0; i < exerciseList.size(); i++){
            if(exerciseList.get(i).getExerciseId().toString().equals(exerciseId)){
                exerciseList.remove(i);
                user.setExercises(exerciseList);
                userRepository.save(user);
                res.makeRes(Constant.MessageType.success, "Delete exercise user successfully!");
                return res;
            }
        }

        res.makeRes(Constant.MessageType.warning, "Don't have this exercise in user");
        return res;
    }
}
