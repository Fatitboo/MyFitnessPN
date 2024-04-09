package dev.MyFitnessPN.server.component;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;


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
