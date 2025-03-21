package dev.MyFitnessPN.server.dtos;

import lombok.*;
import org.bson.types.ObjectId;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RoutineCategoryDTO {
    private String routCategoryId;
    private String name;
    private String description;
}
