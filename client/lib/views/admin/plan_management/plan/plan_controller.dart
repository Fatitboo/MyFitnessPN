import 'dart:convert';
import 'dart:io';
import 'dart:developer';


import 'package:do_an_2/model/components/Description.dart';
import 'package:do_an_2/model/planDTO.dart';
import 'package:do_an_2/model/planTypeDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/network/network_api_service.dart';
import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/status/http_status.dart';

class PlanAdminController extends GetxController{
  var a = "".obs;
  Rx<bool> loading = false.obs;
  final String baseUri = "/plan/";
  RxList listCategory = [].obs;
  var progressValue = 0.0.obs;
  var index = 0.obs;
  RxString thumnailLink = "".obs;

  RxList myPlanList = [].obs;

  RxList<dynamic> planTypeList = [].obs;
  List<dynamic> allPlanList = [].obs;

  Rx<int> selectedPlanType = (-1).obs;
  Rx<Offset> tapPosition = Offset.zero.obs;

  void changePage(int index){
    this.index.value = index;
    progressValue.value = index/4;
  }

  //page 1
  RxMap<String, TextEditingController> textEditController = {
    "title": TextEditingController(),
    "duration": TextEditingController(),
  }.obs;

  List<String> planTypes = [];
  Rx<String> selectedType = "".obs;

  // time per week
  final List<String> timePerWeek = ["1","2","3","4","5","6","7"];
  Rx<String> selectedTimePerWeek = "7".obs;

  // difficulty
  final List<String> difficulty = [
    "Beginner",
    "Intermediate",
    "Advanced"
  ];
  Rx<String> selectedDifficulty = "Beginner".obs;

  // overview
  QuillController overviewController = QuillController.basic();

  //page 2
  //thumbnail
  //page 3
  //descriptions
  RxList<String> descriptionTypes = [
    "What You'll Need On This Plan",
    "Choose This Plan If",
    "What you will do",
    "Sample List of Exercises",
    "Guidelines"
  ].obs;

  RxList descriptionControllers = [].obs;

  //page 4
  //weekDescription

  RxList weekDescriptions = [].obs;

  late final NetworkApiService networkApiService = NetworkApiService();


  RxMap<String, Map<String, String>> validate = {
    "title": {
      ERROR_TYPE.require: "Title is required"
    },
    "duration": {
      ERROR_TYPE.require: "Duration is required",
      ERROR_TYPE.number: "Type number",
    },
  }.obs;

  RxMap<String, Val> errors = {
    "title": Val(false, ""),
    "duration": Val(false, ""),
  }.obs;

  Rx<String> typeForm = "".obs;


  @override
  void onInit() {
    getAllPlanTypes();
    getAllPlans();
  }
  void getAllPlanTypes() async{
    loading.value = true;
    http.Response res = await networkApiService.getApi("/admin/plan-types");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<PlanTypeDTO> planTypes = List<PlanTypeDTO>.from(i.map((model)=> PlanTypeDTO.fromJson(model))).toList();
      planTypeList.value = planTypes;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }
  void filterPlanType(String selectedPlanType){
    myPlanList.value = allPlanList.where((element) => element.planType == selectedPlanType).toList();
  }

  List<Map<String, dynamic>> convertDescription () {
    List<Map<String, dynamic>> listDescription = [];
    for(int i = 0; i < descriptionControllers.value.length; i++){
      var element = descriptionControllers.value.elementAt(i);
      Description description = Description(title: element.keys.elementAt(0), content: jsonEncode(element.values.elementAt(0).document.toDelta().toJson()));
      description.toJson();
      listDescription.add(description.toJson());
    }
    return listDescription;
  }

  List<dynamic> convertWeekDescription () {
    List<Map<String, dynamic>> listWeekDescription = [];
    for(int i = 0; i < descriptionControllers.value.length; i++){
      var element = descriptionControllers.value.elementAt(i);
      Description description = Description(title: element.keys.elementAt(0), content: jsonEncode(element.values.elementAt(0).document.toDelta().toJson()));
      description.toJson();
      listWeekDescription.add(description.toJson());
    }
    return listWeekDescription;
  }

  void getAllPlans () async {
    loading.value = true;
    http.Response res = await networkApiService.getApi("/plan");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<PlanDTO> plans = List<PlanDTO>.from(i.map((model)=> PlanDTO.fromJson(model)));
      allPlanList = plans;
      myPlanList.value = allPlanList;
      print(myPlanList);
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  Future<bool> createPlan (Object plan) async{
    loading.value = true;
    http.Response res = await networkApiService.postApi("/plan/create-plan", plan);
    loading.value = false;
    if(res.statusCode == HttpStatus.created){
      PlanDTO planDTO = PlanDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
      myPlanList.add(planDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }


  Rx<bool> loadingUpload = false.obs;

  final picker = ImagePicker();

  Rx<File> thumbnail = File('').obs;

  void pickThumbnail() async{
    final _image = await picker.pickImage(source: ImageSource.gallery);
    if(_image != null){
      thumbnail.value = File(_image.path);
    }
  }
  void setValueAdd(PlanDTO planDTO) {
    textEditController.value["title"]?.text = planDTO.title!;
    textEditController.value["duration"]?.text = planDTO.duration!.toString();
    selectedTimePerWeek.value = planDTO.timePerWeek!.toString();
    selectedDifficulty.value = planDTO.difficulty!;

    selectedType = (planDTO.planType.toString()).obs;
    overviewController = QuillController.basic();
    overviewController.document = Document.fromJson(jsonDecode(planDTO.overview.toString()));

    descriptionControllers = [].obs;
    for(int i = 0; i < planDTO.descriptions!.length; i++){
      Map<String, QuillController> quillController = {};
      QuillController quill = QuillController.basic();
      quill.document = Document.fromJson(jsonDecode(planDTO.descriptions![i].content.toString()));
      quillController[planDTO.descriptions![i].title!] = quill;
      descriptionControllers.add(quillController);
    }

    weekDescriptions = [].obs;

    for(int i = 0; i < planDTO.weekDescription!.length; i++){
      TextEditingController tctrler = TextEditingController();
      tctrler.text = planDTO.weekDescription![i];
      weekDescriptions.add(tctrler);
    }

    List<String> Wdes = planDTO.descriptions!.map((e) => e.title!).toList();

    thumbnail = File('').obs;
    thumnailLink.value = planDTO.thumbnail!;
    progressValue = 0.0.obs;
    index = 0.obs;
    Set set1 = {
      "What You'll Need On This Plan",
      "Choose This Plan If",
      "What you will do",
      "Sample List of Exercises",
      "Guidelines"
    };
    Set set2 = Set.from(Wdes);
    descriptionTypes = (List<String>.from(set1.difference(set2))).obs;
  }
  void resetValue() {
    textEditController = {
      "title": TextEditingController(),
      "duration": TextEditingController(),
    }.obs;
    selectedTimePerWeek = "7".obs;
    selectedDifficulty = "Beginner".obs;
    selectedType = "".obs;
    overviewController = QuillController.basic();
    descriptionControllers = [].obs;
    weekDescriptions = [].obs;
    thumbnail = File('').obs;
    progressValue = 0.0.obs;
    index = 0.obs;
    descriptionTypes = [
      "What You'll Need On This Plan",
      "Choose This Plan If",
      "What you will do",
      "Sample List of Exercises",
      "Guidelines"
    ].obs;
    thumnailLink = "".obs;
  }
}