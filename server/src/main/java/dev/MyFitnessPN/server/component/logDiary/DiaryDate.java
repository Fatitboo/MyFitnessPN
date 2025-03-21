package dev.MyFitnessPN.server.component.logDiary;

import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DiaryDate {
    private LocalDate logDiaryDate;
    private List<String> logDiaryDateIds;

}
