package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.ExerciseDTO;
import dev.MyFitnessPN.server.component.exercise.Exercise;
import dev.MyFitnessPN.server.models.ExerciseModel;
import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.repositories.ExerciseRepository;
import dev.MyFitnessPN.server.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import dev.MyFitnessPN.server.value.Constant;

import java.time.LocalDateTime;
import java.util.*;


@Service
@RequiredArgsConstructor
public class ExerciseService {
    private final UserRepository userRepository;
    private final ExerciseRepository exerciseRepository;
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
            case "none" -> user.getExercises() != null ? user.getExercises() : new ArrayList<>();
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
                .logAt(exerciseDTO.getLogAt())
                .sets(exerciseDTO.getSets()).build();

        exercise.setExeId(exercise.getExerciseId().toString());

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
                        .exeId(exerciseDTO.getExeId())
                        .name(exerciseDTO.getName())
                        .type(exerciseDTO.getType())
                        .minutes(exerciseDTO.getMinutes())
                        .caloriesBurn(exerciseDTO.getCaloriesBurn())
                        .instruction(exerciseDTO.getInstruction())
                        .video(exerciseDTO.getVideo())
                        .logAt(LocalDateTime.now())
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


    //admin
    public List<ExerciseModel> getAllExerciseAdmin() throws Exception {
        return exerciseRepository.findAll();
    }
    public ExerciseModel createExerciseAdmin(ExerciseDTO exerciseDTO) throws Exception {
        //create new exercise
        ExerciseModel exercise = ExerciseModel.builder()
                .name(exerciseDTO.getName())
                .type(exerciseDTO.getType())
                .instruction(exerciseDTO.getInstruction())
                .video(exerciseDTO.getVideo()).build();
        exercise.setExeId(exerciseRepository.save(exercise).getExerciseId().toString());
        exerciseRepository.save(exercise);
        return exercise;
    }
    public MessageResponse updateExerciseAdmin(ExerciseDTO exerciseDTO, String exerciseId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<ExerciseModel> exerciseOptional = exerciseRepository.findById(new ObjectId(exerciseId));
        if(exerciseOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get exercise in database");
            return res;
        }

        ExerciseModel exercise = exerciseOptional.get();
            exercise.setName(exerciseDTO.getName());
            exercise.setType(exerciseDTO.getType());
            exercise.setInstruction(exerciseDTO.getInstruction());
            exercise.setVideo(exerciseDTO.getVideo());
        res.makeRes(Constant.MessageType.success, "Update exercise successfully!");
        exerciseRepository.save(exercise);
        return res;
    }
    public MessageResponse deleteExerciseAdmin(String exerciseId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<ExerciseModel> exerciseOptional = exerciseRepository.findById(new ObjectId(exerciseId));
        if(exerciseOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when find exercise in database");
            return res;
        }
        exerciseRepository.deleteById(exerciseOptional.get().getExerciseId());
        res.makeRes(Constant.MessageType.success, "Delete exercise successfully");
        return res;
    }
}
