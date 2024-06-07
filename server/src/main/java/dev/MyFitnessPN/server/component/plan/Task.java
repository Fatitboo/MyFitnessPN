package dev.MyFitnessPN.server.component.plan;

import lombok.*;

import java.util.List;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Task {
    private String taskDescription;
    private List<SubTask> subTaskList;
    private int week;
    private int dayOfWeek;
}
