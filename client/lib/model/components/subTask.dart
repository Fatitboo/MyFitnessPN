import 'package:do_an_2/model/routineDTO.dart';

class SubTask {
  String? subTaskName;
  String? subTaskType;  // learn/ workout/ config / article

  //workout
  RoutineDTO? routine;

  // learn/ config / article

  String? subTaskDescription;
  String? subTaskLink; // link to page or link to article or link to video4

  //use for user
  bool? isFinish;

  SubTask({
    this.subTaskName,
    this.subTaskType,  // learn/ workout/ config / article

    //workout
    this.routine,

    // learn/ config / article

    this.subTaskDescription,
    this.subTaskLink, // link to page or link to article or link to video4

    //use for user
    this.isFinish
  });

  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
      subTaskName: json["subTaskName"] ?? "",
      subTaskType: json["subTaskType"] ?? "",  // learn/ workout/ config / article

      //workout
      routine: RoutineDTO.fromJson(json["routine"]),

      // learn/ config / article
      subTaskDescription: json["subTaskDescription"] ?? "",
      subTaskLink: json["subTaskLink"] ?? "", // link to page or link to article or link to video4

      //use for user
      isFinish: json["isFinish"] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
    "subTaskName": subTaskName,
    "subTaskType": subTaskType,  // learn/ workout/ config / article

    //workout
    "routine": routine?.toJson(routine!),

    // learn/ config / article
    "subTaskDescription": subTaskDescription,
    "subTaskLink": subTaskLink, // link to page or link to article or link to video4

    //use for user
    "isFinish": isFinish,
  };
}
