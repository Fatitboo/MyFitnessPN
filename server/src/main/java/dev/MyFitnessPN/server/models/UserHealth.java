package dev.MyFitnessPN.server.models;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import dev.MyFitnessPN.server.component.indexBody.*;
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
@Document(collection = "userHealth")
public class UserHealth  {
    // general information
    @Id
    @JsonSerialize(using = ToStringSerializer.class)
    private ObjectId userHealthId;
    private String userId;
    private double height;
    private double weight;
    private int age;
    private String gender;
    private String exercise;
    private String goal;
    private double goalWeight;
    private double waterIntake;
    BodyMassIndex bodyMassIndex;
    BodyFatPercentage bodyFatPercentage;
    BodyFatPercentage leanBodyMass;
    RestingDailyEnergyExpenditure restingDailyEnergyExpenditure;
    BasalMetabolicRate basalMetabolicRate;
    BasalMetabolicRate totalDailyEnergyExpenditure;
    IdealBodyWeight idealBodyWeight;


    // date create and update
    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;

}
