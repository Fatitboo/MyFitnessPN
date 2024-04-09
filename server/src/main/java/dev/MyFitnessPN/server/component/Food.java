package dev.MyFitnessPN.server.component;

import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Food {
    private String foodId;
    private String foodName;
    private String description;
    private int numberOfServing;
    private int servingSize;
    private Nutrition[] nutrition;

}
