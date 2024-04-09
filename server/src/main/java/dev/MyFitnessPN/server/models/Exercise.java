package dev.MyFitnessPN.server.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import dev.MyFitnessPN.server.component.exercise.Set;
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
public class Exercise {
    private ObjectId exerciseId;
    private String name;
    private String type;
    private double minutes;
    private String caloriesBurn;
    private String instruction;
    private String video;
    private List<Set> sets;
}
