package dev.MyFitnessPN.server.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import dev.MyFitnessPN.server.component.exercise.Exercise;
import dev.MyFitnessPN.server.dtos.ExerciseDTO;
import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Document(collection = "routine")
public class RoutineModel {
    @Id
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId routineId;
    private String routId;
    //use for user
    private String routineName;
    private double plannedVolume;
    private double caloriesBurned;
    private List<ExerciseDTO> exercises;

    //use for admin
    private String video;
    private String type;
    private String category;
    private String workoutOverview;
    private String thumbNail;

    // use both
    private double duration;
    private String description;

}
