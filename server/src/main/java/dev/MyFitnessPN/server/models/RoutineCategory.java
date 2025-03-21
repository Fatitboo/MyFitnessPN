package dev.MyFitnessPN.server.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Document(collection = "routineCategory")
public class RoutineCategory {
    @Id
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId routineCategoryId;
    private String routCategoryId;
    private String name;
    private String description;
}
