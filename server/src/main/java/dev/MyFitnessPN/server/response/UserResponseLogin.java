package dev.MyFitnessPN.server.response;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserResponseLogin {
    private String userId;

    private String fullName;

    private String email;

    private String token;

    private LocalDate dob;

    private String userType;

}
