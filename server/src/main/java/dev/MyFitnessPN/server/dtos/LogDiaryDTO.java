package dev.MyFitnessPN.server.dtos;

import dev.MyFitnessPN.server.component.logDiary.ExerciseLogItem;
import dev.MyFitnessPN.server.component.logDiary.FoodLogItem;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class LogDiaryDTO {
    private String logDiaryId;

    @NotNull(message = "Day log cannot null")
    private LocalDate dateLog;

    private double water;

    private FoodLogItem foodLogItem;

    private ExerciseLogItem exerciseLogItem;

    private String logDiaryType;


}
