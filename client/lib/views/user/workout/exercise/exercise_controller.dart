import 'dart:convert';

import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;

class ExerciseController extends GetxController{
  Rx<bool> loading = false.obs;
  RxList myExercises = [].obs;
  List<dynamic> browserList = [].obs;
  Rx<String> currentWorkoutType = "".obs;
  String userId = "660779c774cb604465279dcf";

  late final NetworkApiService networkApiService;

  final String baseUri = "/api/v1/user/exercises/";
  @override
  void onInit() {
    var params = Get.arguments;
    networkApiService = NetworkApiService();
    currentWorkoutType.value = params["type"].toString();
  }

  void getAllExercise () async {
    loading.value = true;
    http.Response res = await networkApiService.getApi(baseUri + userId);
    loading.value = false;
    Iterable i = json.decode(utf8.decode(res.bodyBytes));
    List<ExerciseDTO> exercises = List<ExerciseDTO>.from(i.map((model)=> ExerciseDTO.fromJson(model))).where((e) => e.type == currentWorkoutType.value.toLowerCase()).toList();
    myExercises.value = exercises;
  }

  void createExercise (ExerciseDTO exeDTO) async{
    loading.value = true;
    http.Response res = await networkApiService.postApi("$baseUri$userId/create-exercise", exeDTO);
    loading.value = false;
    //print(res.body);
  }

  void getBrowserExercise () async {
    // String path = "https://api.api-ninjas.com/v1/exercises?type=strength";
    // http.Response res;
    // res = await http.get(Uri.parse(path), headers: {
    //   'content-type': 'application/json',
    //   'X-Api-Key': 'Ns5faweQ1C+yDh31sjY8ww==dGl9bUIzSEXVvnGW'
    // });
    //
    // Iterable i = json.decode(res.body);
    // List<ExerciseDTO> exercises = List<ExerciseDTO>.from(i.map((model)=> ExerciseDTO.fromJson(jsonDecode(model))));
    // myExercises.value = exercises;
    // print("Hello");
    // print(exercises);
  }

  void onClickTopTabItem(int index){
    switch(index){
      case 1:
        getAllExercise();
        break;
      case 2:
        getBrowserExercise();
        break;
    }
  }
}