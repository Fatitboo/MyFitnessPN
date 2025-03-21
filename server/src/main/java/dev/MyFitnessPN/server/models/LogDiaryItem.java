package dev.MyFitnessPN.server.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import dev.MyFitnessPN.server.component.logDiary.ExerciseLogItem;
import dev.MyFitnessPN.server.component.logDiary.FoodLogItem;
import dev.MyFitnessPN.server.component.meal.Food;
import dev.MyFitnessPN.server.component.meal.Recipe;
import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Document(collection = "logDiaryItem")
public class LogDiaryItem {
    @Id
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId logDiaryItemId;
    private double water;
    private FoodLogItem foodLogItem;
    private ExerciseLogItem exerciseLogItem;
    private String logDiaryType;
    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;

}
