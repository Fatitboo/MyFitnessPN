import 'dart:convert';
import 'dart:io';

import 'package:do_an_2/model/mealDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/network/cloudinary.dart';
import '../../../../data/network/network_api_service.dart';
import '../../../../model/foodDTO.dart';
import '../../../../model/historyDTO.dart';
import '../../../../res/service/remote_service.dart';
import '../../../../res/values/constants.dart';
import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';
import 'package:http/http.dart' as http;

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
  @override
  void onInit() {
    super.onInit();
    type.value = Get.parameters["type"]!;
    print(type.value);
    validate = {"description": {ERROR_TYPE.require: "Required"}, "numberOfServing": {ERROR_TYPE.require: "Required", ERROR_TYPE.number: "Required a number",}};

    if(type.value == "logMeal"||type.value == "updateMeal"){
      indexV.value = Get.parameters['index']!;
      FoodOverviewController f = Get.find<FoodOverviewController>();
      MealDTO mdto = f.myMeal.elementAt(int.parse(indexV.value));
      print(mdto.recipes?.length);
      mealId.value = mdto.mealId!;
      thumbnailLink.value = mdto.photo??"";
      List<RecipeDTO> rl = mdto.recipes!;
      myRecipe.assignAll(rl);
      List<FoodDTO> fl = mdto.foods!;
      myFood.assignAll(fl);
      formController["description"]!.text = "${mdto.description}";
      formController["direction"]!.text = "${mdto.direction}";

    }

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
      item["calories"] = item["calories"]! + f.nutrition!.elementAt(0).amount*cv ?? 0.0;
      item["fat_total_g"] = item["fat_total_g"]! + f.nutrition!.elementAt(2).amount*cv ?? 0.0;
      item["fat_saturated_g"] = item["fat_saturated_g"]! + f.nutrition!.elementAt(3).amount*cv ?? 0.0;
      item["protein_g"] = item["protein_g"]! + f.nutrition!.elementAt(4).amount*cv ?? 0.0;
      item["sodium_mg"] = item["sodium_mg"]! + f.nutrition!.elementAt(5).amount*cv ?? 0.0;
      item["potassium_mg"] = item["potassium_mg"]! + f.nutrition!.elementAt(6).amount*cv ?? 0.0;
      item["cholesterol_mg"] = item["cholesterol_mg"]! + f.nutrition!.elementAt(7).amount*cv ?? 0.0;
      item["carbohydrates_total_g"] = item["carbohydrates_total_g"]! + f.nutrition!.elementAt(8).amount*cv ?? 0.0;
      item["fiber_g"] = item["fiber_g"]! + f.nutrition!.elementAt(9).amount*cv ?? 0.0;
      item["sugar_g"] = item["sugar_g"]! + f.nutrition!.elementAt(10).amount *cv?? 0.0;
    }
    for(RecipeDTO r in myRecipe){
      for (FoodDTO f in r.foods??[]) {
        double cv = (f.numberOfServing??1)*(f.servingSize??100)/100;
        item["calories"] = item["calories"]! + f.nutrition!.elementAt(0).amount*cv *(r.numberOfServing??1) ?? 0.0;
        item["fat_total_g"] = item["fat_total_g"]! + f.nutrition!.elementAt(2).amount*cv*(r.numberOfServing??1)  ?? 0.0;
        item["fat_saturated_g"] = item["fat_saturated_g"]! + f.nutrition!.elementAt(3).amount*cv*(r.numberOfServing??1)  ?? 0.0;
        item["protein_g"] = item["protein_g"]! + f.nutrition!.elementAt(4).amount*cv*(r.numberOfServing??1)  ?? 0.0;
        item["sodium_mg"] = item["sodium_mg"]! + f.nutrition!.elementAt(5).amount*cv*(r.numberOfServing??1)  ?? 0.0;
        item["potassium_mg"] = item["potassium_mg"]! + f.nutrition!.elementAt(6).amount*cv*(r.numberOfServing??1)  ?? 0.0;
        item["cholesterol_mg"] = item["cholesterol_mg"]! + f.nutrition!.elementAt(7).amount*cv*(r.numberOfServing??1)  ?? 0.0;
        item["carbohydrates_total_g"] = item["carbohydrates_total_g"]! + f.nutrition!.elementAt(8).amount*cv*(r.numberOfServing??1)  ?? 0.0;
        item["fiber_g"] = item["fiber_g"]! + f.nutrition!.elementAt(9).amount*cv*(r.numberOfServing??1)  ?? 0.0;
        item["sugar_g"] = item["sugar_g"]! + f.nutrition!.elementAt(10).amount *cv*(r.numberOfServing??1) ?? 0.0;
      }
    }
    formController["calories"]!.text = "${item["calories"]}";
    formController["fat_total_g"]!.text = "${item["fat_total_g"]}";
    formController["fat_saturated_g"]!.text = "${item["fat_saturated_g"]}";
    formController["protein_g"]!.text = "${item["protein_g"]}";
    formController["sodium_mg"]!.text = "${item["sodium_mg"]}";
    formController["potassium_mg"]!.text = "${item["potassium_mg"]}";
    formController["cholesterol_mg"]!.text = "${item["cholesterol_mg"]}";
    formController["carbohydrates_total_g"]!.text = "${item["carbohydrates_total_g"]}";
    formController["fiber_g"]!.text = "${item["fiber_g"]}";
    formController["sugar_g"]!.text = "${item["sugar_g"]}";
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
        "numberOfServing": 1,
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
        "numberOfServing": 1,
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

}
