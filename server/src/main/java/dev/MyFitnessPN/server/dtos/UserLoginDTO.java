package dev.MyFitnessPN.server.dtos;


import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.Date;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserLoginDTO {

    @NotBlank(message = "Username is required")
    @NotNull(message = "Username is required")
    private String username;

    @NotNull(message = "Password cannot null")
    private String password;

    private String userType;

    private int googleAccountId;
}
