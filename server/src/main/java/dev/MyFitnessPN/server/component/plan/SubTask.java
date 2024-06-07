package dev.MyFitnessPN.server.component.plan;

import dev.MyFitnessPN.server.dtos.RoutineDTO;
import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SubTask {
    private String subTaskName;
    private String subTaskType;  // learn/ workout/ config / article

    //workout
    private String routine;

    // learn/ config / article

    private String subTaskDescription;
    private String subTaskLink; // link to page or link to article or link to video4

    //use for user
    private boolean isFinish;
}
