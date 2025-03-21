package dev.MyFitnessPN.server.dtos;


import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserDTO {

    @NotBlank(message = "Username is required")
    @NotNull(message = "Username is required")
    private String username;

    private String password;

    private String cPassword;

    private String fullName;

    private String email;

    @NotNull(message = "Gender cannot null")
    private String gender;

    @NotNull(message = "Goal cannot null")
    private String goal;

    @NotNull(message = "Height cannot null")
    private double height;

    @NotNull(message = "Weight cannot null")
    private double weight;

    @NotNull(message = "Weight goal cannot null")
    private double goalWeight;

    private LocalDate dayOfBirth;

    @NotNull(message = "Exercise level cannot null")
    private String exercise;

    private int googleAccountId;
}
