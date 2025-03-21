package dev.MyFitnessPN.server.dtos;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PlanTypeDTO {
    private String name;
    private String description;
}
