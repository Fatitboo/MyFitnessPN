package dev.MyFitnessPN.server.component.meal;

import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Meal {
    private String mealId;
    private String description;
    private String photo;
    private String mealType;
    private double numberOfServing;
    private Recipe[] recipes;
    private Food[] foods;
    private String direction;

}
