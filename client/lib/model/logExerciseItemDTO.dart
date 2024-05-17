import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/model/routineDTO.dart';
class LogExerciseItemDTO {
  ExerciseDTO? exercise;
  RoutineDTO? routine;
  double? caloryBurned;
  String? exerciseLogType;


  LogExerciseItemDTO(this.exercise, this.routine,  this.caloryBurned, this.exerciseLogType);

  factory LogExerciseItemDTO.fromJson(Map<String, dynamic> json) {
    LogExerciseItemDTO item = LogExerciseItemDTO(
        json["exercise"]!= null ?  ExerciseDTO.fromJson(json["exercise"]) : null,
        json["routine"] != null ?  RoutineDTO.fromJson(json["routine"]) : null,
        json["caloryBurned"] ?? 0 as double,
        json["exerciseLogType"] ,
      );

      return item;
  }


  Map<String, dynamic> toJson() => {
    "exercise": exercise,
    "routine": routine,
    "caloryBurned": caloryBurned,
    "exerciseLogType": exerciseLogType,
  };
}