package dev.MyFitnessPN.server.component.meal;

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
    private double numberOfServing;
    private double servingSize;
    private Nutrition[] nutrition;

}
