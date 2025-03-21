import 'package:do_an_2/model/components/Description.dart';
import 'package:do_an_2/model/components/task.dart';

class PlanDTO {
  String? planId;
  String? planType;
  String? thumbnail;
  String? title;
  int? duration; // number of week
  int? timePerWeek;
  String? overview;
  String? difficulty;
  List<Description>? descriptions;
  List<String>? weekDescription;
  List<Task>? taskList;

  PlanDTO(
   this.planId,
   this.planType,
   this.thumbnail,
   this.title,
   this.duration, // number of week
   this.timePerWeek,
   this.overview,
   this.difficulty,
   this.descriptions,
   this.weekDescription,
   this.taskList
  );

  factory PlanDTO.fromJson(Map<String, dynamic> json) {
    PlanDTO item = PlanDTO(
      json["planId"] ?? "",
      json["planType"] ?? "",
      json["thumbnail"] ?? "",
      json["title"] ?? "",
      json["duration"] ?? "", // number of week
      json["timePerWeek"] ?? "",
      json["overview"] ?? "",
      json["difficulty"] ?? "",
      json["descriptions"] != null ? List<Description>.from(json["descriptions"].map((model)=> Description.fromJson(model))) : [],
      json["weekDescription"] != null ? List<String>.from(json["weekDescription"].map((model)=> model.toString())) : [],
      json["taskList"] != null ? List<Task>.from(json["taskList"].map((model)=> Task.fromJson(model))) : [],
    );
    return item;
  }

  Map<String, dynamic> toJson(PlanDTO planDTO) {
    return {
      "planId": planDTO.planId,
      "planType": planDTO.planType,
      "thumbnail": planDTO.thumbnail,
      "title": planDTO.title,
      "duration": planDTO.duration,
      "timePerWeek": planDTO.timePerWeek,
      "overview": planDTO.overview,
      "difficulty": planDTO.difficulty,
      // "descriptions": planDTO.descriptions,
      // List<Description>.from(json["descriptions"].map((model)=> Description.fromJson(model))),
      // List<String>.from(json["weekDescription"].map((model)=> model.toString())),
      // List<Task>.from(json["taskList"].map((model)=> Task.fromJson(model))),
    };
  }
}