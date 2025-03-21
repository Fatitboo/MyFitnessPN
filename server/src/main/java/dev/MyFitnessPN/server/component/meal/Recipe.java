package dev.MyFitnessPN.server.component.meal;

import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Recipe {
    private String recipeId;
    private String title;
    private double numberOfServing;
    private Food[] foods;

}
