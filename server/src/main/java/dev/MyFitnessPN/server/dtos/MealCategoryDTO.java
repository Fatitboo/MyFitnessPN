package dev.MyFitnessPN.server.dtos;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MealCategoryDTO {
    private String mealCategoryId;
    private String name;
    private String description;
}
