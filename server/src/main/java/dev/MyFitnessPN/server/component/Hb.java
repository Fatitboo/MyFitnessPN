package dev.MyFitnessPN.server.component;
import lombok.*;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Hb {
    private String formulaName;
    private Calories calories;
    private Calories joules;

}
