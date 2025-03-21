import 'package:do_an_2/model/components/subTask.dart';

class Task {
  String? taskDescription;
  List<SubTask>? subTaskList;
  int week;
  int dayOfWeek;

  Task(
    this.taskDescription,
    this.subTaskList,
    this.week,
    this.dayOfWeek,
  );


  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json["taskDescription"] ?? "",
      json["subTaskList"] != null ? List<SubTask>.from(json["subTaskList"].map((model)=> SubTask.fromJson(model))) : [],
      json["week"] ?? 0,
      json["dayOfWeek"] ?? 0
    );
  }
  Map<String, dynamic> toJson() => {
    "taskDescription": taskDescription,
    "subTaskList": subTaskList,
    "week": week,
    "dayOfWeek": dayOfWeek
  };
}