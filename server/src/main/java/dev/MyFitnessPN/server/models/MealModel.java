package dev.MyFitnessPN.server.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import dev.MyFitnessPN.server.component.meal.Food;
import dev.MyFitnessPN.server.component.meal.Recipe;
import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Document(collection = "meal")
public class MealModel {
    @Id
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId mealId;
    private String description;
    private String photo;
    private String mealType;
    private double numberOfServing;
    private List<Recipe> recipes;
    private List<Food> foods;
    private String direction;


}
