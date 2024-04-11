package dev.MyFitnessPN.server.component.indexBody;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BasalMetabolicRate {
    private Hb hb;
    private Hb rs;
    private Hb msj;
    private Hb bmi;
}
