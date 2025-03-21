package dev.MyFitnessPN.server.component.logDiary;

import dev.MyFitnessPN.server.component.meal.Food;
import dev.MyFitnessPN.server.component.meal.Meal;
import dev.MyFitnessPN.server.component.meal.Recipe;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FoodLogItem {
    private Food food;
    private Recipe recipe;
    private Meal meal;
    private double servingSize;
    private double numberOfServing;
    private String foodLogType; // food , recipe , meal
}
