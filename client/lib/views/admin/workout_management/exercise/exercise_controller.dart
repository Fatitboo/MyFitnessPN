import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ExerciseController extends GetxController{
  Rx<bool> loading = false.obs;
  RxList myExercises = [].obs;
  RxList myExercisesHistory = [].obs;
  RxList browserList = [].obs;
  Rx<String> currentWorkoutType = "strength".obs;
  String userId = "660779c774cb604465279dcf";
  late ExerciseDTO selected;
  Rx<String> from = "".obs;

  final List<String> itemsType = [
    'Strength',
    'Cardio',
  ];
  Rx<String> selectedType = "Strength".obs;
  Rx<bool> isVisibleVideo = false.obs;
  Rx<bool> isPlayVideo = false.obs;
  Rx<bool> loadingUpload = false.obs;
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  File? video;
  Rx<bool> isSelectFromEdit = false.obs;

  final picker = ImagePicker();

  pickVideo() async {
    final _video = await picker.pickVideo(source: ImageSource.gallery);
    if(_video != null){
      isVisibleVideo.value = true;
      video = File(_video.path);
      videoPlayerController = VideoPlayerController.file(video!);
      videoPlayerController.addListener(() {
        if(videoPlayerController.value.position == videoPlayerController.value.duration) {
          isPlayVideo.value = false;
        }
      });
      initializeVideoPlayerFuture = videoPlayerController.initialize();
    }
  }

  late final NetworkApiService networkApiService;
  Rx<Offset> tapPosition = Offset.zero.obs;


  final String baseUri = "/user/exercises/";
  @override
  void onInit() {
    networkApiService = NetworkApiService();
    getAllExercise();
  }

  void onChangeValueDropdownBtn(String value){
    selectedType.value = value;
  }


  void getAllExercise () async {
    loading.value = true;
    http.Response res = await networkApiService.getApi("${baseUri}admin");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      print(res.body);
      List<ExerciseDTO> exercises = List<ExerciseDTO>.from(i.map((model)=> ExerciseDTO.fromJson(model))).toList();
      myExercises.value = exercises;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  Future<bool> createExercise (Object exe) async{
    loading.value = true;
    http.Response res = await networkApiService.postApi("${baseUri}admin/create-exercise-admin", exe);
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

  Future<bool> updateExercise (ExerciseDTO exeDTO, Object exe, String exeId) async{
    loading.value = true;
    http.Response res = await networkApiService.putApi("${baseUri}update-exercise-admin/$exeId", exe);
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
    http.Response res = await networkApiService.deleteApi("${baseUri}delete-exercise-admin/$exeId");
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

  void getAllRoutineCategory() async{
    loading.value = true;
    http.Response res = await networkApiService.getApi("/api/v1/admin/routine-categories");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<ExerciseDTO> exercises = List<ExerciseDTO>.from(i.map((model)=> ExerciseDTO.fromJson(model))).toList();
      myExercises.value = exercises;
      print(myExercises.value);
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  void onClickTopTabItem(int index){

  }
  String toTimeFormat(int snds) {
    int hours   = (snds / 3600).floor();
    int minutes = ((snds - (hours * 3600)) / 60).floor();
    int seconds = snds - (hours * 3600) - (minutes * 60);
    return '$minutes:0$seconds';
  }

  void resetValue() {
    selectedType = "Strength".obs;
    isVisibleVideo = false.obs;
    isPlayVideo = false.obs;
    loadingUpload = false.obs;
    isSelectFromEdit = false.obs;
    video = null;
  }

  Rx<String> fromPage = "workout".obs;

  void setFromPage(String value){
    fromPage.value = value;
  }
}