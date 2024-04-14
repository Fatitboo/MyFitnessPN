package dev.MyFitnessPN.server.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import dev.MyFitnessPN.server.component.exercise.Exercise;
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
    //use for user
    private String routineName;
    private String description;
    private double plannedVolume;
    private double caloriesBurned;
    private List<String> exercises;

    //use for admin
    private String video;
    private String type;
    private String category;

    // use both
    private double duration;
}
