package dev.MyFitnessPN.server.component.indexBody;
import lombok.*;
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BodyMassIndex {
    private double value;
    private String conclusion;
    private String unit;
}
