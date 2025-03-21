package dev.MyFitnessPN.server.component.indexBody;
import lombok.*;

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
