import 'dart:convert';

import 'package:do_an_2/model/components/set.dart';
class ExerciseDTO {
  String name;
  String type;
  double? minutes;
  double caloriesBurn;
  String? instruction;
  String? video;
  List<Set>? sets;
  DateTime? logAt;
  ExerciseDTO(
    this.name,
    this.type,
    this.minutes,
    this.caloriesBurn,
    this.instruction,
    this.video,
    this.sets,
  );

  ExerciseDTO.initStrength(
    this.name,
    this.type,
    this.sets,
    this.caloriesBurn,
  );
  ExerciseDTO.initCardio(
      this.name,
      this.type,
      this.minutes,
      this.caloriesBurn,
  );

  factory ExerciseDTO.fromJson(Map<String, dynamic> json) {
      ExerciseDTO item = ExerciseDTO(
        json["name"] ?? "",
        json["type"] ?? "",
        json["minutes"] ?? 0 as double,
        json["caloriesBurn"] ?? 0 as double,
        json["instruction"] ?? "",
        json["video"] ?? "",
        json["sets"] != null ? (json["sets"] as List).map((e) => Set.fromJson(e)).toList() : [],
      );
      if(json["logAt"] != null){
        item.logAt = json["logAt"];
      }
      return item;
  }

  String getStringStrengthValues(){
    return "${sets?.length} sets, ${sets?[0].rep} reps, ${sets?[0].weight} kg";
  }

  String getStringCardioValues(){
    return "$minutes minutes, $caloriesBurn calo";
  }

}