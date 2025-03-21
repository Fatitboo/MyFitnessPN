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
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Document(collection = "exercise")
public class ExerciseModel {
    @Id
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId exerciseId;
    private String exeId;
    private String name;
    private String type;
    private String instruction;
    private String video;
}
