package dev.MyFitnessPN.server.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import dev.MyFitnessPN.server.component.plan.Description;
import dev.MyFitnessPN.server.component.plan.Task;
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
@Document(collection = "plan")
public class Plan {
    @Id
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId planId;
    private String planType;
    private String thumbnail;
    private String title;
    private int duration; // number of week
    private int timePerWeek;
    private String overview;
    private String difficulty;
    private List<Description> descriptions;
    private List<String> weekDescription;
    private List<Task> taskList;
}
