package dev.MyFitnessPN.server.component.logDiary;

import dev.MyFitnessPN.server.component.exercise.Exercise;
import dev.MyFitnessPN.server.component.exercise.Routine;
import dev.MyFitnessPN.server.component.meal.Food;
import dev.MyFitnessPN.server.component.meal.Meal;
import dev.MyFitnessPN.server.component.meal.Recipe;
import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ExerciseLogItem {
    private Exercise exercise;
    private Routine routine;
    private double caloryBurned;
    private String exerciseLogType; // exercise , routine
}
