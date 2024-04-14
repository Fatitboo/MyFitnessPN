import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;

class ExerciseController extends GetxController{
  Rx<bool> loading = false.obs;
  RxList myExercises = [].obs;
  RxList myExercisesHistory = [].obs;
  RxList browserList = [].obs;
  Rx<String> currentWorkoutType = "".obs;
  String userId = "660779c774cb604465279dcf";
  late ExerciseDTO selected;
  Rx<String> from = "".obs;

  late final NetworkApiService networkApiService;
  Rx<Offset> tapPosition = Offset.zero.obs;

  final String baseUri = "/user/exercises/";
  @override
  void onInit() {
    var params = Get.arguments;
    networkApiService = NetworkApiService();
    currentWorkoutType.value = params["type"].toString();
    from.value = params["from"];
    getAllExercise();
  }

  void getAllExercise () async {
    loading.value = true;
    http.Response res = await networkApiService.getApi(baseUri + userId);
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<ExerciseDTO> exercises = List<ExerciseDTO>.from(i.map((model)=> ExerciseDTO.fromJson(model))).where((e) => e.type == currentWorkoutType.value.toLowerCase()).toList();
      myExercises.value = exercises;
      exercises = exercises.where((e) => e.logAt != null).toList();
      exercises.sort((a, b) => a.logAt!.isAfter(b.logAt!) ? 1 : -1);
      myExercisesHistory.value = exercises;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  Future<bool> createExercise (Object exe) async{
    loading.value = true;
    http.Response res = await networkApiService.postApi("$baseUri$userId/create-exercise", exe);
    loading.value = false;
    if(res.statusCode == HttpStatus.created){
      ExerciseDTO exerciseDTO = ExerciseDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
      myExercises.add(exerciseDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }

  Future<bool> logExercise (ExerciseDTO exeDTO, Object exe, String exeId) async{
    loading.value = true;
    http.Response res = await networkApiService.putApi("$baseUri$userId/update-exercise/$exeId", exe);
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      int index = myExercises.indexWhere((element) => element.id == exeId);
      myExercises.removeAt(index);
      myExercises.insert(index, exeDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }

  Future<bool> deleteExercise (String exeId, int index) async{
    loading.value = true;
    http.Response res = await networkApiService.deleteApi("$baseUri$userId/delete-exercise/$exeId");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      myExercises.removeAt(index);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }

  void getBrowserExercise () async {
    loading.value = true;
    http.Response res = await networkApiService.getApi("${baseUri}admin");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<ExerciseDTO> exercises = List<ExerciseDTO>.from(i.map((model)=> ExerciseDTO.fromJson(model))).where((e) => e.type == currentWorkoutType.value.toLowerCase()).toList();
      browserList.value = exercises;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  void onClickTopTabItem(int index){
    switch(index){
      case 1:
        // getAllExercise();
        break;
      case 2:
        getBrowserExercise();
        break;
    }
  }
}