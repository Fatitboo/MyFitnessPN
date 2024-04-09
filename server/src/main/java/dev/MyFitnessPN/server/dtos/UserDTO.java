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

    @NotNull(message = "Password cannot null")
    private String password;

    @NotNull(message = "Confirm Password cannot null")
    private String cPassword;

    @NotNull(message = "Full name cannot null")
    private String fullName;

    @NotNull(message = "Email cannot null")
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

    @NotNull(message = "Day of birth cannot null")
    private LocalDate dayOfBirth;

    @NotNull(message = "Exercise level cannot null")
    private String exercise;



    private int googleAccountId;
}
