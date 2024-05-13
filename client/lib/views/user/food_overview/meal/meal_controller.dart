import 'dart:convert';
import 'dart:io';

import 'package:do_an_2/model/mealDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../data/network/cloudinary.dart';
import '../../../../data/network/network_api_service.dart';
import '../../../../model/foodDTO.dart';
import '../../../../model/historyDTO.dart';
import '../../../../model/logDiaryDTO.dart';
import '../../../../res/service/remote_service.dart';
import '../../../../res/values/constants.dart';
import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';
import 'package:http/http.dart' as http;

import '../../../admin/meal_management/discover_recipes/discover_recipes_controller.dart';
import '../../diary/diary_controller.dart';

class MealController extends GetxController {
  TextEditingController txtSearch = TextEditingController();
  final List<String> itemsMeal = ['Breakfast', 'Lunch', 'Dinner', 'Snack',];
  var selectedMeal = "Breakfast".obs;
  var isShow = false.obs;
  FocusNode focusNode = FocusNode();
  var isEnable = false.obs;
  var type = "".obs;
  var indexV = "".obs;
  var thumbnailLink = "".obs;
  var mealId = "".obs;

  final picker = ImagePicker();
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  Map<String, TextEditingController> formController = {
    "description": TextEditingController(),
    "direction": TextEditingController(),
    "numberOfServing": TextEditingController(),
    "calories": TextEditingController(),
    "fat_total_g": TextEditingController(),
    "fat_saturated_g": TextEditingController(),
    "cholesterol_mg": TextEditingController(),
    "protein_g": TextEditingController(),
    "sodium_mg": TextEditingController(),
    "potassium_mg": TextEditingController(),
    "carbohydrates_total_g": TextEditingController(),
    "fiber_g": TextEditingController(),
    "sugar_g": TextEditingController(),
  };
  late Map<String, Map<String, String>> validate;
  RxMap<String, Val> errors = {"description": Val(false, ""), "numberOfServing": Val(false, ""),}.obs;
  List<FoodDTO> foods = [];
  RxList search = [].obs;
  RxList myHistory = <HistoryDTO>[].obs;
  RxList myIngredients = <FoodDTO>[].obs;
  RxList myFood = <FoodDTO>[].obs;
  RxList myRecipe = <RecipeDTO>[].obs;
  MealDTO disMeal = MealDTO("", "", "", "", 1, [], [], "");

  @override
  void onInit() {
    super.onInit();
    type.value = Get.parameters["type"]!;
    print(type.value);
    validate = {"description": {ERROR_TYPE.require: "Required"}, "numberOfServing": {ERROR_TYPE.require: "Required", ERROR_TYPE.number: "Required a number",}};
    formController["numberOfServing"]!.text = "${1.0}";
    if(type.value == "updateMeal"){
      indexV.value = Get.parameters['index']!;
      FoodOverviewController f = Get.find<FoodOverviewController>();
      MealDTO mdto = f.myMeal.elementAt(int.parse(indexV.value));
      disMeal = mdto;
      print(mdto.recipes?.length);
      mealId.value = mdto.mealId!;
      thumbnailLink.value = mdto.photo??"";
      List<RecipeDTO> rl = mdto.recipes!;
      myRecipe.assignAll(rl);
      formController["numberOfServing"]!.text = mdto.numberOfServing.toString() ??"1.0";

      List<FoodDTO> fl = mdto.foods!;
      myFood.assignAll(fl);
      formController["description"]!.text = "${mdto.description}";
      formController["direction"]!.text = "${mdto.direction}";
    }
    if(type.value == "logMeal" ){
      indexV.value = Get.parameters['index']!;
      FoodOverviewController f = Get.find<FoodOverviewController>();
      MealDTO mdto = f.myMeal.elementAt(int.parse(indexV.value));
      disMeal = mdto;
      print(mdto.recipes?.length);
      mealId.value = mdto.mealId!;
      thumbnailLink.value = mdto.photo??"";
      List<RecipeDTO> rl = mdto.recipes!;
      myRecipe.assignAll(rl);
      formController["numberOfServing"]!.text = "1.0";

      List<FoodDTO> fl = mdto.foods!;
      myFood.assignAll(fl);
      formController["description"]!.text = "${mdto.description}";
      formController["direction"]!.text = "${mdto.direction}";
    }
    if(type.value == "logMealFromDiscoverPage"){
      DiscoverRecipesController discoverRecipesController = Get.find<DiscoverRecipesController>();
      int index = int.parse(Get.parameters["index"]!);
      String? mealType = Get.parameters["mealType"];
      formController["numberOfServing"]!.text = "1.0";

      for (var element in discoverRecipesController.listMealByCategory) {
        if(mealType == element.mealType){
          disMeal = element.meals.elementAt(index);
          break;
        }
      }
      formController["direction"]!.text = disMeal.direction! ;
      formController["description"]!.text = disMeal.description!;
      thumbnailLink.value = disMeal.photo!;
      mealId.value = disMeal.mealId!;
      List<FoodDTO> fl = disMeal.foods!;
      myFood.assignAll(fl);
    }

    updateData();
  }
  void onChangeSize(String item){

    updateData();
  }
  Rx<File> thumbnail = File('').obs;
  void pickThumbnail() async{
    final _image = await picker.pickImage(source: ImageSource.gallery);
    if(_image != null){
      thumbnail.value = File(_image.path);
    }
  }
  void updateData() {
    var item = {
      "calories": 0.0,
      "fat_total_g": 0.0,
      "fat_saturated_g": 0.0,
      "protein_g": 0.0,
      "sodium_mg": 0.0,
      "potassium_mg": 0.0,
      "cholesterol_mg": 0.0,
      "carbohydrates_total_g": 0.0,
      "fiber_g": 0.0,
      "sugar_g": 0.0
    };
    for (FoodDTO f in myFood) {
      double cv = (f.numberOfServing??1)*(f.servingSize??100)/100;
      item["calories"] = item["calories"]! + f.nutrition!.elementAt(0).amount*cv;
      item["fat_total_g"] = item["fat_total_g"]! + f.nutrition!.elementAt(2).amount*cv;
      item["fat_saturated_g"] = item["fat_saturated_g"]! + f.nutrition!.elementAt(3).amount*cv;
      item["protein_g"] = item["protein_g"]! + f.nutrition!.elementAt(4).amount*cv;
      item["sodium_mg"] = item["sodium_mg"]! + f.nutrition!.elementAt(5).amount*cv;
      item["potassium_mg"] = item["potassium_mg"]! + f.nutrition!.elementAt(6).amount*cv;
      item["cholesterol_mg"] = item["cholesterol_mg"]! + f.nutrition!.elementAt(7).amount*cv;
      item["carbohydrates_total_g"] = item["carbohydrates_total_g"]! + f.nutrition!.elementAt(8).amount*cv;
      item["fiber_g"] = item["fiber_g"]! + f.nutrition!.elementAt(9).amount*cv;
      item["sugar_g"] = item["sugar_g"]! + f.nutrition!.elementAt(10).amount *cv;
    }
    for(RecipeDTO r in myRecipe){
      for (FoodDTO f in r.foods??[]) {
        double cv = (f.numberOfServing??1)*(f.servingSize??100)/100;
        item["calories"] = item["calories"]! + f.nutrition!.elementAt(0).amount*cv *(r.numberOfServing??1);
        item["fat_total_g"] = item["fat_total_g"]! + f.nutrition!.elementAt(2).amount*cv*(r.numberOfServing??1);
        item["fat_saturated_g"] = item["fat_saturated_g"]! + f.nutrition!.elementAt(3).amount*cv*(r.numberOfServing??1);
        item["protein_g"] = item["protein_g"]! + f.nutrition!.elementAt(4).amount*cv*(r.numberOfServing??1);
        item["sodium_mg"] = item["sodium_mg"]! + f.nutrition!.elementAt(5).amount*cv*(r.numberOfServing??1);
        item["potassium_mg"] = item["potassium_mg"]! + f.nutrition!.elementAt(6).amount*cv*(r.numberOfServing??1);
        item["cholesterol_mg"] = item["cholesterol_mg"]! + f.nutrition!.elementAt(7).amount*cv*(r.numberOfServing??1);
        item["carbohydrates_total_g"] = item["carbohydrates_total_g"]! + f.nutrition!.elementAt(8).amount*cv*(r.numberOfServing??1);
        item["fiber_g"] = item["fiber_g"]! + f.nutrition!.elementAt(9).amount*cv*(r.numberOfServing??1);
        item["sugar_g"] = item["sugar_g"]! + f.nutrition!.elementAt(10).amount *cv*(r.numberOfServing??1);
      }
    }
    double i = double.parse(formController["numberOfServing"]?.text ?? "1" );

    if(type.value == "logMealFromDiscoverPage"||type.value == "logMeal"){
      formController["calories"]!.text = (item["calories"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["fat_total_g"]!.text = (item["fat_total_g"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["fat_saturated_g"]!.text = (item["fat_saturated_g"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["protein_g"]!.text = (item["protein_g"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["sodium_mg"]!.text = (item["sodium_mg"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["potassium_mg"]!.text = (item["potassium_mg"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["cholesterol_mg"]!.text = (item["cholesterol_mg"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["carbohydrates_total_g"]!.text = (item["carbohydrates_total_g"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["fiber_g"]!.text = (item["fiber_g"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
      formController["sugar_g"]!.text = (item["sugar_g"]!*i / disMeal.numberOfServing!).toStringAsFixed(2);
    }
    else{
      formController["calories"]!.text = (item["calories"]!/i ).toStringAsFixed(2);
      formController["fat_total_g"]!.text = (item["fat_total_g"]!/i ).toStringAsFixed(2);
      formController["fat_saturated_g"]!.text = (item["fat_saturated_g"]!/i ).toStringAsFixed(2);
      formController["protein_g"]!.text = (item["protein_g"]!/i ).toStringAsFixed(2);
      formController["sodium_mg"]!.text = (item["sodium_mg"]!/i ).toStringAsFixed(2);
      formController["potassium_mg"]!.text = (item["potassium_mg"]!/i ).toStringAsFixed(2);
      formController["cholesterol_mg"]!.text = (item["cholesterol_mg"]!/i ).toStringAsFixed(2);
      formController["carbohydrates_total_g"]!.text = (item["carbohydrates_total_g"]!/i ).toStringAsFixed(2);
      formController["fiber_g"]!.text = (item["fiber_g"]!/i ).toStringAsFixed(2);
      formController["sugar_g"]!.text = (item["sugar_g"]!/i ).toStringAsFixed(2);
    }

  }

  void getFoodsFromApi(String queryString) async {
    if (queryString.length <= 2) {
      Get.defaultDialog(
          radius: 8,
          title: "Search term too short",
          middleText: "Please enter a search term that is at least 2 characters long.",
          textConfirm: "Dismiss",
          onConfirm: () {
            Get.close(1);
          });
    } else {
      foods.clear();
      foods = await RemoteService().getFoodsFromApi(queryString);
      search = [].obs;
      for (FoodDTO f in foods) {
        search.add(HistoryDTO(f.foodId, f.foodName, f.getStringDescription(), "food"));
      }
      myHistory.refresh();
      myHistory = search;
      update();
    }
  }

  Future<void> handleAddMeal() async {
    if(myFood.isEmpty && myRecipe.isEmpty){
      Get.defaultDialog(
          radius: 8,
          title: "Please add meal item",
          middleText: "Please add meal item to track nutrient.",
          textCancel: "OK",
          onCancel: (){}
      );
      return;
    }
    if(formController["description"]!.text.toString().trim().isEmpty){
      Get.defaultDialog(
          radius: 8,
          title: "Please fill input",
          middleText: "Fill input required.",
          textCancel: "Dismiss",
          onCancel: (){}
      );
    }
    else {
      var item;
      String url = "";
      if(thumbnail.value.path.isNotEmpty){
        Map<String, dynamic> resImg = await CloudinaryNetWork().upload(Constant.CLOUDINARY_USER_MEAL_IMAGE, thumbnail.value, Constant.FILE_TYPE_image);
        if(resImg["isSuccess"]){
         url = resImg["imageUrl"];

        }
        else{
          print(resImg["message"]);
          Get.defaultDialog(
              radius: 8,
              title: "Have some error?",
              middleText: "Have some error when upload image.",
              textCancel: "Dismiss");
          return;
        }
      }

      item = {
        "mealId": "",
        "description": formController["description"]!.text.toString().trim()??"",
        "direction": formController["direction"]!.text.toString().trim()??"",
        "photo": url,
        "mealType":"PersonalAdd",
        "numberOfServing": formController["numberOfServing"]?.text.toString().trim(),
        "foods": myFood.toJson(),
        "recipes": myRecipe.toJson()
      };
      Object obj = jsonEncode(item);
      print(obj);

      NetworkApiService networkApiService = NetworkApiService();
      FoodOverviewController clr = Get.find<FoodOverviewController>();
      // loading.value = true;
      http.Response res = await networkApiService.postApi("/foods/${clr.loginResponse.userId}/createMeal", obj);
      // loading.value = false;
      if (res.statusCode == 200) {
        clr.myHistory.refresh();

        http.Response res = await networkApiService.getApi("/foods/${clr.loginResponse.userId}/getMeals");
        // loading.value = false;

        if (res.statusCode == 200) {
          Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));

          List<MealDTO> rec = List<MealDTO>.from(i["meals"].map((model) => MealDTO.fromJson(model))).toList();
          clr.myMeal.refresh();

          clr.myMeal = rec.obs;

          clr.update();

        }
        Get.back();
      }
    }



  }
  Future<void> handleUpdateMeal() async {
    if(myFood.isEmpty && myRecipe.isEmpty){
      Get.defaultDialog(
          radius: 8,
          title: "Please add meal item",
          middleText: "Please add meal item to track nutrient.",
          textCancel: "OK",
          onCancel: (){}
      );
      return;
    }
    if(formController["description"]!.text.toString().trim().isEmpty){
      Get.defaultDialog(
          radius: 8,
          title: "Please fill input",
          middleText: "Fill input required.",
          textCancel: "Dismiss",
          onCancel: (){}
      );
    }
    else {
      var item;
      String url = thumbnailLink.value;
      if(thumbnail.value.path.isNotEmpty){
        if(thumbnailLink.value.isNotEmpty){
          bool isSuccess = await CloudinaryNetWork().delete(thumbnailLink.value!, Constant.FILE_TYPE_image);
        }
        Map<String, dynamic> resImg = await CloudinaryNetWork().upload(Constant.CLOUDINARY_USER_MEAL_IMAGE, thumbnail.value, Constant.FILE_TYPE_image);
        if(resImg["isSuccess"]){
          url = resImg["imageUrl"];
        }
        else{
          print(resImg["message"]);
          Get.defaultDialog(
              radius: 8,
              title: "Have some error?",
              middleText: "Have some error when upload image.",
              textCancel: "Dismiss");
          return;
        }

      }

      item = {
        "mealId": mealId.value,
        "description": formController["description"]!.text.toString().trim()??"",
        "direction": formController["direction"]!.text.toString().trim()??"",
        "photo": url,
        "mealType":"PersonalAdd",
        "numberOfServing": formController["numberOfServing"]?.text.toString().trim(),
        "foods": myFood.toJson(),
        "recipes": myRecipe.toJson()
      };
      Object obj = jsonEncode(item);
      print(obj);

      NetworkApiService networkApiService = NetworkApiService();
      FoodOverviewController clr = Get.find<FoodOverviewController>();
      // loading.value = true;
      http.Response res = await networkApiService.postApi("/foods/${clr.loginResponse.userId}/updateMeal", obj);
      // loading.value = false;
      if (res.statusCode == 200) {
        clr.myHistory.refresh();

        http.Response res = await networkApiService.getApi("/foods/${clr.loginResponse.userId}/getMeals");
        // loading.value = false;

        if (res.statusCode == 200) {
          Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));

          List<MealDTO> rec = List<MealDTO>.from(i["meals"].map((model) => MealDTO.fromJson(model))).toList();
          clr.myMeal.refresh();

          clr.myMeal = rec.obs;

          clr.update();

        }
        Get.back();
      }
    }
  }

  Future<void> logFood( ) async {
    DateTime now = DateTime.now();
    print("cc");
    String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
    var item;
      item = {
        "logDiaryId": "",
        "dateLog": formattedDateTime,
        "foodLogItem": {
          "meal": disMeal.toJson(),
          "numberOfServing": double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0"),
          "foodLogType": "meal"
        },
        "logDiaryType": selectedMeal.value
      };

    Object obj = jsonEncode(item);
    NetworkApiService networkApiService = NetworkApiService();
    FoodOverviewController clr = Get.find<FoodOverviewController>();
    http.Response res = await networkApiService.postApi("/log-diary/add-log/${clr.loginResponse.userId}", obj);

    if(res.statusCode == 200){
      LogDiaryDTO logDiaryDTO = LogDiaryDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
      DiaryController diaryController = Get.find<DiaryController>();
      if(selectedMeal.value == "Breakfast"){
        diaryController.breakfast.add(logDiaryDTO);
      }else if(selectedMeal.value == "Lunch"){
        diaryController.lunch.add(logDiaryDTO);
      }else if(selectedMeal.value == "Dinner"){
        diaryController.dinner.add(logDiaryDTO);
      }else if(selectedMeal.value == "Snack"){
        diaryController.snack.add(logDiaryDTO);
      }
    }
    Get.close(2);
  }


}
