package dev.MyFitnessPN.server.component;

import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Nutrition {
    private String nutritionName;
    private double amount;
    private String unit;

}
