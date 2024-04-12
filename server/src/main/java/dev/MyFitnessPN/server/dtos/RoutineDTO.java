package dev.MyFitnessPN.server.dtos;

import dev.MyFitnessPN.server.component.exercise.Exercise;
import lombok.*;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RoutineDTO {
    //use for user
    private String routineName;
    private String description;
    private double plannedVolume;
    private double duration;
    private double caloriesBurned;
    private List<Exercise> exercises;

    //use for admin
    private String video;
    private String type;
    private String category;
}
