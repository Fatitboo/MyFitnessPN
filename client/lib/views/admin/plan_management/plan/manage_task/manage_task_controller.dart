import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:do_an_2/model/components/subTask.dart';
import 'package:do_an_2/model/components/task.dart';
import 'package:do_an_2/model/planDTO.dart';
import 'package:do_an_2/model/routineDTO.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ManageTaskController extends GetxController{
  late PlanDTO planDTO;
  RxBool loading = false.obs;
  RxInt currentWeek = 0.obs;
  RxList selectedWeekDay = [].obs;
  RxList tasks = [].obs;
  RxList currentDaysOfWeek = [].obs;
  RxList isHideRestDaysOfWeek = [].obs;
  final String baseUri = "/plan/";
  final NetworkApiService networkApiService = NetworkApiService();

  @override
  void onInit() {
    planDTO = Get.arguments['item'];

    for(int i = 0; i < planDTO.duration!; i++){
      selectedWeekDay.value.add(0);
      isHideRestDaysOfWeek.value.add(false);
    }
    for(int i = 1; i <= planDTO.duration! * 7; i++){
      int week = (i / 7).ceil();
      int dayOfWeek =  i % 7 == 0 ? 7 : i % 7;
      var task = planDTO.taskList![i - 1];
      if(task.week == week && task.dayOfWeek == dayOfWeek){
        TextEditingController des = TextEditingController();
        des.text = task.taskDescription!;

        var subTaskList = [];
        for(int j = 0; j < task.subTaskList!.length; j++){
          var subTask = task.subTaskList![j];

          var subTaskName = TextEditingController();
          var subTaskDescription = TextEditingController();
          var subTaskLink = TextEditingController();

          subTaskName.text = subTask.subTaskName!;
          subTaskDescription.text = subTask.subTaskDescription!;
          subTaskLink.text = subTask.subTaskLink!;

          subTaskList.add({
            "subTaskName": subTaskName,
            "subTaskType": subTask.subTaskType,  // learn/ workout/ config / article
            "subTaskDescription": subTaskDescription,
            "subTaskLink": subTaskLink,
            "routine": null,
          });
        }
        tasks.add(
            {
              "week": week,
              "dayOfWeek": dayOfWeek,
              "taskDescription": des,
              "subTaskList": subTaskList,
            }
        );
        currentDaysOfWeek.value.add(true);
      }
      else{
        tasks.add(
            {
              "week": week,
              "dayOfWeek": dayOfWeek,
              "taskDescription": TextEditingController(),
              "subTaskList": [].obs,
            }
        );
        currentDaysOfWeek.value.add(false);
      }
    }
    checkFullDaysOfWeek(0);
    loadWorkoutInfo(0);
  }

  Future<bool> saveTasks(BuildContext context) async {
    if(validateData(context)){
      Object data = prepareData();

      loading.value = true;
      http.Response res = await networkApiService.putApi("${baseUri}update-plan-tasks/${planDTO.planId}", data);
      loading.value = false;
      if(res.statusCode == HttpStatus.ok){
        print("Plan created successfully");
        return true;
      }
      else{
        Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
        print(resMessage["message"]);
        return false;
      }
    }
    return false;
  }

  Object prepareData(){
    var obj = [];
    for(int i = 0; i < currentDaysOfWeek.length; i++){
      if(currentDaysOfWeek.value[i]){
        var taskObj = {};
        var subTaskList = [];
        for(int j = 0; j < tasks.value[i]["subTaskList"].length; j++){
          var subTaskItem = {};
          subTaskItem["subTaskName"] = tasks.value[i]["subTaskList"][j]["subTaskName"].text;
          subTaskItem["subTaskType"] = tasks.value[i]["subTaskList"][j]["subTaskType"];
          subTaskItem["subTaskDescription"] = tasks.value[i]["subTaskList"][j]["subTaskDescription"].text;
          subTaskItem["subTaskLink"] = tasks.value[i]["subTaskList"][j]["subTaskLink"].text;
          subTaskItem["routine"] = tasks.value[i]["subTaskList"][j]["routine"]?.routId;
          subTaskList.add(subTaskItem);
        }

        taskObj["week"] = tasks.value[i]["week"];
        taskObj["dayOfWeek"] = tasks.value[i]["dayOfWeek"];
        taskObj["taskDescription"] = tasks.value[i]["taskDescription"].text;
        taskObj["subTaskList"] = subTaskList;
        obj.add(taskObj);
      }
      else{
        obj.add({});
      }
    }

    return jsonEncode(obj);
  }

  bool validateData(BuildContext context) {
    for(int i = 0; i < planDTO.duration! * 7; i++){
      if(currentDaysOfWeek.value[i]){
        if(tasks.value[i]["taskDescription"].text.isEmpty){
          showDialog(context: context, builder: (BuildContext context) {
            return customDialog("Warning", "Missing task overview in ${getWeekDay((i % 7))}day week ${((i + 1) / 7).floor()}", context);
          });
          return false;
        }
        if(tasks.value[i]["subTaskList"].isEmpty){
          showDialog(context: context, builder: (BuildContext context) {
            return customDialog("Warning","You need to add sub tasks in ${getWeekDay((i % 7).floor())}day week ${i + 1}", context);
          });
          return false;
        }
        for(int j = 0; j < tasks.value[i]["subTaskList"].length; j++){
          var subTask = tasks.value[i]["subTaskList"][j];
          if(subTask["subTaskName"].text.isEmpty){
            showDialog(context: context, builder: (BuildContext context) {
              return customDialog("Warning","Missing sub task name in ${getWeekDay((i % 7).floor())}day week ${i + 1}", context);
            });
            return false;
          }
          if((subTask["subTaskType"] == Constant.SUBTASK_normal
           || subTask["subTaskType"] == Constant.SUBTASK_link
              )
           && subTask["subTaskDescription"].text.isEmpty){
            showDialog(context: context, builder: (BuildContext context) {
              return customDialog("Warning","Missing sub task description in ${getWeekDay((i % 7).floor())}day of Week ${i + 1}", context);
            });
            return false;
          }

          if(subTask["subTaskType"] == Constant.SUBTASK_link
            && subTask["subTaskLink"].text.isEmpty){
            showDialog(context: context, builder: (BuildContext context) {
              return customDialog("Warning","Missing sub task link in ${getWeekDay((i % 7).floor())}day week ${i + 1}", context);
            });
            return false;
          }

          if(subTask["subTaskType"] == Constant.SUBTASK_workout
              && subTask["routine"] == null){
            showDialog(context: context, builder: (BuildContext context) {
              return customDialog("Warning","Missing sub task routine in ${getWeekDay((i % 7).floor())}day week ${i + 1}", context);
            });
            return false;
          }
        }
      }
    }

    for(int i = 0; i < planDTO.duration!; i++){
      int sum = currentDaysOfWeek.value.sublist(i * 7, (i + 1) * 7).fold(0, (value, element) =>
        element ?  value = value + 1 : value
      );
      if(sum != planDTO.timePerWeek){
        showDialog(context: context, builder: (BuildContext context) {
          return customDialog("Warning", "Missing task in Week ${i + 1}", context);
        });
        return false;
      }
    }
    return true;
  }

  AlertDialog customDialog(String title, String description, BuildContext context){
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void addSubTaskToTask(int index, String type){
    tasks.value[index]['subTaskList'].add({
      "subTaskName": TextEditingController(),
      "subTaskType": type,  // learn/ workout/ config / article
      "subTaskDescription": TextEditingController(),
      "subTaskLink": TextEditingController(),
      "routine": null,
    });
    if(!currentDaysOfWeek.value[index]){
      currentDaysOfWeek.value[index] = true;
      checkFullDaysOfWeek((index / 7).floor());
    }
  }

  void checkFullDaysOfWeek(int currentWeek) {
    int sum = currentDaysOfWeek.value.sublist(currentWeek * 7, (currentWeek + 1) * 7).fold(0, (value, element) =>
      element ?  value = value + 1 : value
    );
    isHideRestDaysOfWeek.value[currentWeek] = sum == planDTO.timePerWeek!;
  }

  void removeSubTaskOutTask(int indexTask, int indexSubTask){
    tasks.value[indexTask]['subTaskList'].removeAt(indexSubTask);
    if(tasks.value[indexTask]['subTaskList'].isEmpty){
      currentDaysOfWeek.value[indexTask] = false;

      checkFullDaysOfWeek((indexTask / 7).floor());
    }
  }

  void loadWorkoutInfo(int planIndex) async {

    loading.value = true;
    List<String> subTaskListStr;
    List<int> indexWorkout;
    (subTaskListStr, indexWorkout) = getListStringWorkout(planDTO.taskList![planIndex]);
    Object obj = jsonEncode(subTaskListStr);
    http.Response res = await networkApiService.postApi("/user/routines/several", obj);
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<RoutineDTO> routines = List<RoutineDTO>.from(i.map((model)=> RoutineDTO.fromJson(model))).toList();
      for(int i = 0; i < subTaskListStr.length; i++){
        tasks.value[planIndex]["subTaskList"][indexWorkout[i]]["routine"] = routines[i];
      }
      tasks.refresh();
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  (List<String>, List<int>) getListStringWorkout(Task task){
    List<String> subTaskListStr = [];
    List<int> indexWorkout = [];
    List<SubTask> subTaskList = task.subTaskList!;
    for(int i = 0; i < subTaskList.length; i++){
      if(subTaskList[i].subTaskType == Constant.SUBTASK_workout.toLowerCase()){
        subTaskListStr.add(subTaskList[i].routine!);
        indexWorkout.add(i);
      }
    }
    return (subTaskListStr, indexWorkout);
  }

  String getWeekDay(int index){
    switch(index){
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thur';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      case 6:
        return 'Sun';
      default:
        return 'Unknown';
    }
  }
}