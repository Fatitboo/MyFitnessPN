import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/network/network_api_service.dart';
import '../../../../model/routineDTO.dart';
import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/status/http_status.dart';

class RoutineController extends GetxController{
  var a = "".obs;
  Rx<bool> loading = false.obs;
  final String baseUri = "/user/routines/";
  String userId = "660779c774cb604465279dcf";
  Rx<String> selectedId = "".obs;
  RxList myRoutineList = [].obs;

  RxMap<String, TextEditingController> textEditController = {
    "routineName": TextEditingController(),
    "description": TextEditingController(),
    "plannedVolume": TextEditingController(),
    "duration": TextEditingController(),
    "caloriesBurned": TextEditingController(),
  }.obs;
  late final NetworkApiService networkApiService = NetworkApiService();

  RxMap<String, Map<String, String>> validate = {
    "routineName": {
      ERROR_TYPE.require: "Name is required"
    },
    "plannedVolume": {
      ERROR_TYPE.require: "Required",
      ERROR_TYPE.number: "Type number",
    },
    "duration": {
      ERROR_TYPE.require: "Required",
      ERROR_TYPE.number: "Type number",
    },
    "caloriesBurned": {
      ERROR_TYPE.require: "Required",
      ERROR_TYPE.number: "Type number",
    },
  }.obs;

  RxMap<String, Val> errors = {
    "routineName": Val(false, ""),
    "plannedVolume": Val(false, ""),
    "duration": Val(false, ""),
    "caloriesBurned": Val(false, ""),
  }.obs;

  RxList textEditExercise = [].obs;

  RxList validateExes = [].obs;

  RxList  errorExes = [].obs;

  Rx<String> typeForm = "".obs;

  void addExercise(String value){
    TextEditingController name = TextEditingController();
    name.text = value;
    textEditExercise.add(
      {
        "name": name,
        "type": TextEditingController(),
        "instruction": TextEditingController(),
        "sets": [{
          "rep": TextEditingController(),
          "weight": TextEditingController()
        }]
      }
    );
    validateExes.add(
      {
        "sets": [{
          "weight": {
            ERROR_TYPE.require: "Required",
            ERROR_TYPE.number: "Type number!",
          },
          "rep": {
            ERROR_TYPE.require: "Required",
            ERROR_TYPE.number: "Type number!",
          },
        }]
      }
    );
    errorExes.add(
      {
        "sets": [{
          "rep": Val(false, ""),
          "weight": Val(false, ""),
        }]
      }
    );
  }

  void getAllRoutineUser () async {
    loading.value = true;
    http.Response res = await networkApiService.getApi(baseUri + userId);
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<RoutineDTO> exercises = List<RoutineDTO>.from(i.map((model)=> RoutineDTO.fromJson(model)));
      myRoutineList.value = exercises;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  Future<bool> createRoutine (Object routine) async{
    loading.value = true;
    http.Response res = await networkApiService.postApi("$baseUri$userId/create-routine", routine);
    loading.value = false;
    if(res.statusCode == HttpStatus.created){
      RoutineDTO routineDTO = RoutineDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
      myRoutineList.add(routineDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }

  Future<bool> updateRoutine (Object routine, Map<String, dynamic> objJson) async{
    loading.value = true;
    http.Response res = await networkApiService.putApi("$baseUri$userId/update-routine/${selectedId.value}", routine);
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      RoutineDTO routineDTO = RoutineDTO.fromJson(objJson);
      routineDTO.routId = selectedId.value;

      int index = myRoutineList.indexWhere((element) => element.routId == selectedId.value);
      myRoutineList.removeAt(index);
      myRoutineList.insert(index, routineDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }

  Future<bool> deleteExercise (String routineId, int index) async{
    loading.value = true;
    http.Response res = await networkApiService.deleteApi("$baseUri$userId/delete-routine/$routineId");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      myRoutineList.removeAt(index);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }


  void onClickTopTabItem(int index){
    switch(index){
      case 1:
        getAllRoutineUser();
        break;
    }
  }

  void setValue(RoutineDTO routDTO){
    typeForm.value = "update";
    selectedId.value = routDTO.routId!;
    textEditController["routineName"]?.text = routDTO.routineName!;
    textEditController["description"]?.text = routDTO.description!;
    textEditController["plannedVolume"]?.text = routDTO.plannedVolume!.toString();
    textEditController["duration"]?.text = routDTO.duration!.toString();
    textEditController["caloriesBurned"]?.text = routDTO.caloriesBurned!.toString();

    for(int i = 0; i < routDTO.exercises!.length; i++){
      addExercise(routDTO.exercises![i].name.toString());
      textEditExercise[i]["type"].text = routDTO.exercises?[i].type;
      textEditExercise[i]["instruction"].text = routDTO.exercises?[i].instruction;
      for(int j = 0; j < routDTO.exercises![i].sets!.length; j++){
        if(j > 0) {
          textEditExercise[i]["sets"].add(
            {
              "rep": TextEditingController(),
              "weight": TextEditingController()
            }
          );
          errorExes[i]["sets"].add({
            "rep": Val(false, ""),
            "weight": Val(false, ""),
          });
          validateExes[i]["sets"].add({
            "weight": {
              ERROR_TYPE.require: "Required",
              ERROR_TYPE.number: "Type number!",
            },
            "rep": {
              ERROR_TYPE.require: "Required",
              ERROR_TYPE.number: "Type number!",
            },
          });
        }
        textEditExercise[i]["sets"][j]["weight"].text = routDTO.exercises?[i].sets![j].weight.toString();
        textEditExercise[i]["sets"][j]["rep"].text = routDTO.exercises?[i].sets![j].rep.toString();
      }
    }
  }

  void resetValue(){
    textEditController.value = {
      "routineName": TextEditingController(),
      "description": TextEditingController(),
      "plannedVolume": TextEditingController(),
      "duration": TextEditingController(),
      "caloriesBurned": TextEditingController(),
    };
    validate.value = {
      "routineName": {
        ERROR_TYPE.require: "Name is required"
      },
      "plannedVolume": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Type number",
      },
      "duration": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Type number",
      },
      "caloriesBurned": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Type number",
      },
    };
    errors.value = {
      "routineName": Val(false, ""),
      "plannedVolume": Val(false, ""),
      "duration": Val(false, ""),
      "caloriesBurned": Val(false, ""),
    };
    textEditExercise.value = [];
    validateExes.value = [];
    errorExes.value = [];
    typeForm.value = "";
  }
}