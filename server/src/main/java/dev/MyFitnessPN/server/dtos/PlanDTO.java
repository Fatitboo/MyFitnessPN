package dev.MyFitnessPN.server.dtos;

import dev.MyFitnessPN.server.component.plan.Description;
import dev.MyFitnessPN.server.component.plan.Task;
import lombok.*;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PlanDTO {
    private String planId;
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
