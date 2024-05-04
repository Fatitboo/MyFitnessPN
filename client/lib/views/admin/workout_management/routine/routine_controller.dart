import 'dart:convert';
import 'dart:io';

import 'package:do_an_2/model/routineCategoryDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/network/network_api_service.dart';
import '../../../../model/exerciseDTO.dart';
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
  RxList listCategory = [].obs;
  RxList listExercises = [].obs;
  Rx<RoutineCategoryDTO> selectedRoutineCategory = RoutineCategoryDTO.init().obs;
  var progressValue = 0.0.obs;
  var index = 0.obs;

  final List<String> routineTypes = [
    'Bodyweight',
    'Minimal Equipment',
    'No Equipment',
  ];

  Rx<String> selectedType = "Bodyweight".obs;

  List<String> categoryTypesList = [];

  Rx<String> selectedCategory = "".obs;

  Rx<Offset> tapPosition = Offset.zero.obs;

  void changePage(int index){
    this.index.value = index;
    progressValue.value = index/4;
  }

  //page 1

  RxMap<String, TextEditingController> textEditController = {
    "routineName": TextEditingController(),
    "duration": TextEditingController(),
  }.obs;
    // selected type
    // selectedCategory

  QuillController workoutOverviewController = QuillController.basic();

  //page 2
    //video
  //page 3
  QuillController descriptionController = QuillController.basic();



  late final NetworkApiService networkApiService = NetworkApiService();


  RxMap<String, Map<String, String>> validate = {
    "routineName": {
      ERROR_TYPE.require: "Name is required"
    },
    "duration": {
      ERROR_TYPE.require: "Required",
      ERROR_TYPE.number: "Type number",
    },
  }.obs;

  RxMap<String, Val> errors = {
    "routineName": Val(false, ""),
    "duration": Val(false, ""),
    "workoutOverview": Val(false, ""),
  }.obs;

  RxList textEditExercise = [].obs;

  RxList validateExes = [].obs;

  RxList  errorExes = [].obs;

  Rx<String> typeForm = "".obs;

  void addExercise(String value, String type){
    TextEditingController name = TextEditingController();
    name.text = value;
    TextEditingController typeText = TextEditingController();
    typeText.text = type;
    if(type == "strength"){
      textEditExercise.add(
          {
            "name": name,
            "type": typeText,
            "instruction": TextEditingController(),
            "sets": [{
              "rep": TextEditingController(),
              "weight": TextEditingController()
            }],
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
            }],
          }
      );
      errorExes.add(
          {
            "sets": [{
              "rep": Val(false, ""),
              "weight": Val(false, ""),
            }],
          }
      );
    }
    else{
      textEditExercise.add(
          {
            "name": name,
            "type": typeText,
            "instruction": TextEditingController(),
            "minutes": TextEditingController(),
          }
      );
      validateExes.add(
        {
          "minutes": {
            ERROR_TYPE.require: "Required",
            ERROR_TYPE.number: "Type number!",
          },
        }
      );
      errorExes.add(
        {
          "minutes": Val(false, ""),
        }
      );
    }
  }

  void getAllRoutineCategory() async{
    loading.value = true;
    http.Response res = await networkApiService.getApi("/admin/routine-categories");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<RoutineCategoryDTO> routineCategories = List<RoutineCategoryDTO>.from(i.map((model)=> RoutineCategoryDTO.fromJson(model))).toList();
      listCategory.value = routineCategories;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }
  Future<bool> createRoutineCategory (Object routineCategory) async{
    loading.value = true;
    http.Response res = await networkApiService.postApi("/admin/routine-categories/create-routine-category", routineCategory);
    loading.value = false;
    if(res.statusCode == HttpStatus.created){
      RoutineCategoryDTO routineCategoryDTO = RoutineCategoryDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
      listCategory.add(routineCategoryDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }
  Future<bool> updateRoutineCategory (Object routineCategory, Map<String, dynamic> objJson) async{
    loading.value = true;
    http.Response res = await networkApiService.putApi("/admin/routine-categories/update-routine-category/${selectedRoutineCategory.value.routCategoryId}", routineCategory);
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      RoutineCategoryDTO routineCategoryDTO = RoutineCategoryDTO.fromJson(objJson);
      print(routineCategoryDTO.routCategoryId);
      int index = listCategory.indexWhere((element) => element.routCategoryId == selectedRoutineCategory.value.routCategoryId);
      listCategory.removeAt(index);
      listCategory.insert(index, routineCategoryDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }
  Future<bool> deleteRoutineCategory (String routineId, int index) async{
    loading.value = true;
    http.Response res = await networkApiService.deleteApi("/admin/routine-categories/delete-routine-category/$routineId");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      listCategory.removeAt(index);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }

  // routine
  void getAllRoutine () async {
    loading.value = true;
    http.Response res = await networkApiService.getApi("${baseUri}admin");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<RoutineDTO> routines = List<RoutineDTO>.from(i.map((model)=> RoutineDTO.fromJson(model)));
      myRoutineList.value = routines;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  Future<bool> createRoutine (Object routine) async{
    loading.value = true;
    http.Response res = await networkApiService.postApi("${baseUri}create-routine-admin", routine);
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

  void setValue(RoutineDTO routDTO){
    typeForm.value = "update";
    selectedId.value = routDTO.routId!;
    textEditController["routineName"]?.text = routDTO.routineName!;
    textEditController["description"]?.text = routDTO.description!;
    textEditController["plannedVolume"]?.text = routDTO.plannedVolume!.toString();
    textEditController["duration"]?.text = routDTO.duration!.toString();
    textEditController["caloriesBurned"]?.text = routDTO.caloriesBurned!.toString();

    for(int i = 0; i < routDTO.exercises!.length; i++){
      addExercise(routDTO.exercises![i].name.toString(), routDTO.exercises![i].type.toString());
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
      "duration": TextEditingController(),
    };
    validate.value = {
      "routineName": {
        ERROR_TYPE.require: "Name is required"
      },
      "duration": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Type number",
      },
    };
    errors.value = {
      "routineName": Val(false, ""),
      "duration": Val(false, ""),
      "workoutOverview": Val(false, ""),
    };
    textEditExercise.value = [];
    listExercises.value = [];
    validateExes.value = [];
    errorExes.value = [];
    typeForm.value = "";
    isVisibleVideo.value = false;
    isPlayVideo.value = false;
    loadingUpload.value = false;
    video = null;
    thumbnail.value = File('');
    workoutOverviewController = QuillController.basic();
    descriptionController = QuillController.basic();
    progressValue.value = 0;
    index.value = 0;
  }

  void onChangeValueDropdownRoutineType(String value){
    selectedType.value = value;
  }
  void onChangeValueDropdownRoutineCategory(String value){
    selectedCategory.value = value;
  }
  void setCategoryTypesList () async{
    http.Response res = await networkApiService.getApi("/admin/routine-categories");
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<RoutineCategoryDTO> routineCategories = List<RoutineCategoryDTO>.from(i.map((model)=> RoutineCategoryDTO.fromJson(model))).toList();
      categoryTypesList = routineCategories.map((e) => e.name as String).toList();
      selectedCategory.value = categoryTypesList[0];
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  Rx<bool> isVisibleVideo = false.obs;
  Rx<bool> isPlayVideo = false.obs;
  Rx<bool> loadingUpload = false.obs;
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  File? video;

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

  String toTimeFormat(int snds) {
    int hours   = (snds / 3600).floor();
    int minutes = ((snds - (hours * 3600)) / 60).floor();
    int seconds = snds - (hours * 3600) - (minutes * 60);
    return '$minutes:0$seconds';
  }

  void addExerciseToList(ExerciseDTO exerciseDTO){
    listExercises.add(exerciseDTO);
    addExercise(exerciseDTO.name!, exerciseDTO.type!);
  }
  Rx<File> thumbnail = File('').obs;
  void pickThumbnail() async{
    final _image = await picker.pickImage(source: ImageSource.gallery);
    if(_image != null){

      thumbnail.value = File(_image.path);
    }
  }
}