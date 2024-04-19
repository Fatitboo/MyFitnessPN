package dev.MyFitnessPN.server.component.exercise;

import dev.MyFitnessPN.server.dtos.ExerciseDTO;
import dev.MyFitnessPN.server.dtos.RoutineDTO;
import lombok.*;
import org.bson.types.ObjectId;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Routine {
    private ObjectId routineId;
    private String routId;

    //use for user
    private String routineName;
    private String description;
    private double plannedVolume;
    private double duration;
    private double caloriesBurned;
    private List<ExerciseDTO> exercises;

    //use for admin
    private String video;
    private String type;
    private String category;
}
