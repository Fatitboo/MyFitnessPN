package dev.MyFitnessPN.server.component.indexBody;
import lombok.*;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Calories {
    private double value;
    private List<String> unit;
}
