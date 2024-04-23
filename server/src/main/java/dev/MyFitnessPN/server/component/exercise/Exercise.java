package dev.MyFitnessPN.server.component.exercise;

import lombok.*;
import org.bson.types.ObjectId;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Exercise {
    private ObjectId exerciseId;
    private String exeId;
    private String name;
    private String type;
    private double minutes;
    private double caloriesBurn;
    private String instruction;
    private String video;
    private List<Set> sets;

    private LocalDateTime logAt;
}