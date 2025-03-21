package dev.MyFitnessPN.server.component.indexBody;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Devine {
    private String formulaName;
    private Calories metric;
    private Calories imperial;
}
