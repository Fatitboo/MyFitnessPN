import 'package:do_an_2/model/components/subTask.dart';

class Task {
  String? taskName;
  String? taskDescription;
  List<SubTask>? subTaskList;

  Task(
    this.taskName,
    this.taskDescription,
    this.subTaskList,
  );


  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json["taskName"] ?? "",
      json["taskDescription"] ?? "",
      json["subTaskList"] != null ? List<SubTask>.from(json["subTaskList"].map((model)=> SubTask.fromJson(model))) : [],
    );
  }
  Map<String, dynamic> toJson() => {
    "taskName": taskName,
    "taskDescription": taskDescription,
    "subTaskList": subTaskList,
  };
}