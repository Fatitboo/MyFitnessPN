package dev.MyFitnessPN.server.component;
import lombok.*;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Bmi {
    private String formulaName;
    private double value;
    private String conclusion;
    private List<String> unit;
}
