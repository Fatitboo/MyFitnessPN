package dev.MyFitnessPN.server.component.exercise;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Set {
    private int rep;
    private double weight;
    private int count;
}
