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
    private int weight;
    private int count;
}
