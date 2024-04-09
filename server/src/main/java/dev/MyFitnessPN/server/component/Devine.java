package dev.MyFitnessPN.server.component;

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
