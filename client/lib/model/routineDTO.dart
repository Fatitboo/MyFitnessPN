import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:objectid/objectid.dart';

class RoutineDTO {
  //use for user
  String? routId;
  String? routineName;
  String? description;
  double? plannedVolume;
  double? duration;
  double? caloriesBurned;
  List<ExerciseDTO>? exercises;

  //use for admin
  String? video;
  String? type;
  String? category;

  RoutineDTO(
    this.routId,
    this.routineName,
    this.description,
    this.plannedVolume,
    this.duration,
    this.caloriesBurned,
    this.exercises,

    //use for admin
    this.video,
    this.type,
    this.category
  );

  factory RoutineDTO.fromJson(Map<String, dynamic> json) {
    RoutineDTO item = RoutineDTO(
      json["routId"] ?? "",
      json["routineName"] ?? "",
      json["description"] ?? "",
      double.tryParse(json["plannedVolume"].toString()) ?? 0,
      double.tryParse(json["duration"].toString()) ?? 0,
      json["caloriesBurned"] ?? "",
      List<ExerciseDTO>.from(json["exercises"].map((model)=> ExerciseDTO.fromJson(model))),
      json["video"] ?? "",
      json["type"] ?? "",
      json["category"] ?? "",
    );
    return item;
  }

  Map<String, dynamic> toJson(RoutineDTO routineDTO) {
    List<Map<String, dynamic>> exes = [];
    for(int i = 0; i < routineDTO.exercises!.length; i++){
      List<Map<String, dynamic>> sets = [];
      for(int j = 0; j < routineDTO.exercises![i].sets!.length; j++){
        sets.add({
          "rep": routineDTO.exercises![i].sets?[j].rep,
          "weight": routineDTO.exercises![i].sets?[j].weight,
          "count": 1,
        });
      }
      exes.add({
        "name": routineDTO.exercises![i].name,
        "type": routineDTO.exercises![i].type,
        "instruction": routineDTO.exercises![i].instruction,
        "sets": sets
      });
    }

    return {
      "routId": routineDTO.routId,
      "routineName": routineDTO.routineName,
      "description": routineDTO.description,
      "plannedVolume": routineDTO.plannedVolume,
      "duration": routineDTO.duration,
      "caloriesBurned": routineDTO.caloriesBurned,
      "exercises": exes,
    };
  }
}