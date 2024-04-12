package dev.MyFitnessPN.server.dtos;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import dev.MyFitnessPN.server.component.exercise.Set;
import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ExerciseDTO {
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
