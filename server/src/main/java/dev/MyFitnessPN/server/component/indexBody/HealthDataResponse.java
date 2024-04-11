package dev.MyFitnessPN.server.component.indexBody;

import lombok.*;


@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HealthDataResponse {
    // general information
    private double height;
    private double weight;
    private int age;
    private String gender;
    private String exercise;
    private String goal;
    private double goalWeight;

    BodyMassIndex bodyMassIndex;
    BodyFatPercentage bodyFatPercentage;
    BodyFatPercentage leanBodyMass;
    RestingDailyEnergyExpenditure restingDailyEnergyExpenditure;
    BasalMetabolicRate basalMetabolicRate;
    BasalMetabolicRate totalDailyEnergyExpenditure;
    IdealBodyWeight idealBodyWeight;


    // date create and update


}
