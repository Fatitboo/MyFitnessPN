package dev.MyFitnessPN.server.response;
import lombok.*;
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

    private String userType;

}
