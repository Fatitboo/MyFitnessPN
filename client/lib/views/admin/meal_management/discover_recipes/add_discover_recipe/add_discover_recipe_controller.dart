import 'dart:convert';
import 'dart:io';

import 'package:do_an_2/model/foodCategoryDTO.dart';
import 'package:do_an_2/model/mealDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/discover_recipes_controller.dart';
import 'package:do_an_2/views/admin/meal_management/meal_management_controller.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../../data/network/cloudinary.dart';
import '../../../../../data/network/network_api_service.dart';
import '../../../../../model/foodDTO.dart';
import '../../../../../model/historyDTO.dart';
import '../../../../../res/service/remote_service.dart';
import '../../../../../res/values/constants.dart';
import '../../../../../validate/Validator.dart';
import '../../../../../validate/error_type.dart';


class AddDiscoverRecipeController extends GetxController {

  Map<String, TextEditingController> formController = {
    "title": TextEditingController(),
    "numberOfServing": TextEditingController(),
    "direction":TextEditingController(),
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
  RxMap<String, Val> errors = {
    "title": Val(false, ""),
    "numberOfServing": Val(false, ""),
  }.obs;

  TextEditingController txtSearch = TextEditingController();
  var selectedMealType = "Select meal type".obs;
  RxList itemsMealType = [].obs;

  late Map<String, Map<String, String>> validate;
  List<FoodDTO> foods = [];
  RxList search = [].obs;
  RxList myHistory = <HistoryDTO>[].obs;
  RxList<FoodDTO> myIngredients = <FoodDTO>[].obs;


  var indexV = "".obs;
  var mealId = "".obs;
  var type = "".obs;
  var thumbnailLink = "".obs;
  var isShow = false.obs;
  final picker = ImagePicker();
  late final MealDTO disMeal;
  @override
  void onInit() {
    super.onInit();
    formController["numberOfServing"]!.text = "${1.0}";
    MealManagementController mealManagementController = Get.find<MealManagementController>();
    List<String> listMealCate = [];
    for (var element in mealManagementController.listCategory) {
      listMealCate.add(element.name??"");
    }
    itemsMealType = listMealCate.obs;
    type.value = Get.parameters["type"]??"";
    validate = {"title": {ERROR_TYPE.require: "Required"}, "numberOfServing": {ERROR_TYPE.require: "Required", ERROR_TYPE.number: "Require a number",}};
    if (type.value == "editDis"){
      DiscoverRecipesController discoverRecipesController = Get.find<DiscoverRecipesController>();
      int index = Get.arguments["index"];
      String mealType = Get.arguments["mealType"];


      for (var element in discoverRecipesController.listMealByCategory) {
        if(mealType == element.mealType){
          disMeal = element.meals.elementAt(index);
          break;
        }
      }

      formController["numberOfServing"]!.text = disMeal.numberOfServing.toString() ??"1.0";
      selectedMealType.value = disMeal.mealType!;
      formController["direction"]!.text = disMeal.direction! ;
      formController["title"]!.text = disMeal.description!;
      thumbnailLink.value = disMeal.photo!;
      mealId.value = disMeal.mealId!;
      myIngredients.value = disMeal.foods??[];
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
    for (FoodDTO f in myIngredients) {
      double cv = (f.numberOfServing ?? 1)*(f.servingSize??100)/100;
      item["calories"] = item["calories"]! + f.nutrition!.elementAt(0).amount*cv?? 0.0 ;
      item["fat_total_g"] = item["fat_total_g"]! + f.nutrition!.elementAt(2).amount*cv ?? 0.0;
      item["fat_saturated_g"] = item["fat_saturated_g"]! + f.nutrition!.elementAt(3).amount*cv ?? 0.0;
      item["protein_g"] = item["protein_g"]! + f.nutrition!.elementAt(4).amount*cv ?? 0.0;
      item["sodium_mg"] = item["sodium_mg"]! + f.nutrition!.elementAt(5).amount*cv ?? 0.0;
      item["potassium_mg"] = item["potassium_mg"]! + f.nutrition!.elementAt(6).amount*cv ?? 0.0;
      item["cholesterol_mg"] = item["cholesterol_mg"]! + f.nutrition!.elementAt(7).amount*cv ?? 0.0;
      item["carbohydrates_total_g"] = item["carbohydrates_total_g"]! + f.nutrition!.elementAt(8).amount*cv ?? 0.0;
      item["fiber_g"] = item["fiber_g"]! + f.nutrition!.elementAt(9).amount*cv ?? 0.0;
      item["sugar_g"] = item["sugar_g"]! + f.nutrition!.elementAt(10).amount*cv ?? 0.0;
    }
    double i = double.parse(formController["numberOfServing"]!.text ?? "1" );
    formController["calories"]!.text = "${item["calories"]!/i}";
    formController["fat_total_g"]!.text = "${item["fat_total_g"]!/i}";
    formController["fat_saturated_g"]!.text = "${item["fat_saturated_g"]!/i}";
    formController["protein_g"]!.text = "${item["protein_g"]!/i}";
    formController["sodium_mg"]!.text = "${item["sodium_mg"]!/i}";
    formController["potassium_mg"]!.text = "${item["potassium_mg"]!/i}";
    formController["cholesterol_mg"]!.text = "${item["cholesterol_mg"]!/i}";
    formController["carbohydrates_total_g"]!.text = "${item["carbohydrates_total_g"]!/i}";
    formController["fiber_g"]!.text = "${item["fiber_g"]!/i}";
    formController["sugar_g"]!.text = "${item["sugar_g"]!/i}";
  }
  void onChangeSize(String item){
    updateData();
  }
  void getFoodsFromApi(String queryString) async {
    if (queryString.length <= 2) {
      Get.defaultDialog(
          radius: 8,
          title: "Search term too short",
          middleText: "Please enter a search term that is at least 2 characters long.",
          textConfirm: "Dismiss",
          onConfirm: () {Get.close(1);}
      );
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





  Future<void> handleAddRecipeDiscover() async {
    if(myIngredients.isEmpty){
      Get.defaultDialog(
          radius: 8,
          title: "Please add meal item",
          middleText: "Please add meal item to track nutrient.",
          textCancel: "OK",
          onCancel: (){}
      );
      return;
    }
    if(formController["title"]!.text.toString().trim().isEmpty){
      Get.defaultDialog(
          radius: 8,
          title: "Please fill input",
          middleText: "Fill input required.",
          textCancel: "Dismiss",
          onCancel: (){}
      );
    }
    if(selectedMealType.value == 'Select meal type'){
      Get.defaultDialog(
          radius: 8,
          title: "Please choose meal type",
          middleText: "Choose meal type.",
          textCancel: "Dismiss",
          onCancel: (){}
      );
    }
    else{
      var item;
      String url = "";
      if(thumbnail.value.path.isNotEmpty){
        Map<String, dynamic> resImg = await CloudinaryNetWork().upload(Constant.CLOUDINARY_ADMIN_RECIPE_IMAGE, thumbnail.value, Constant.FILE_TYPE_image);
        if( resImg["isSuccess"] ) {
          url = resImg["imageUrl"];
        }
        else {
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
        "description": formController["title"]?.text.toString().trim(),
        "direction": formController["direction"]?.text.toString().trim(),
        "photo":url,
        "mealType":"",
        "numberOfServing": formController["numberOfServing"]?.text.toString().trim(),
        "foods": myIngredients.toJson(),
        "recipes":[]
      };
      Object obj = jsonEncode(item);
      print(obj);

      NetworkApiService networkApiService = NetworkApiService();
      DiscoverRecipesController clr = Get.find<DiscoverRecipesController>();
      // loading.value = true;
      http.Response res = await networkApiService.postApi("/meal/create-discover-meal", obj);
      // loading.value = false;
      if (res.statusCode == 200) {
        clr.listMealByCategory.refresh();
        MealDTO mealDTO = MealDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
        clr.listMealByCategory.add(mealDTO);
        Get.back();
      }
    }

  }

  Future<void> handleUpdateRecipeDiscover() async {
    if(myIngredients.isEmpty){
      Get.defaultDialog(
          radius: 8,
          title: "Please add meal item",
          middleText: "Please add meal item to track nutrient.",
          textCancel: "OK",
          onCancel: (){}
      );
      return;
    }
    if(formController["title"]!.text.toString().trim().isEmpty){
      Get.defaultDialog(
          radius: 8,
          title: "Please fill input",
          middleText: "Fill input required.",
          textCancel: "Dismiss",
          onCancel: (){}
      );
    }

    else{
      var item;
      String url = thumbnailLink.value;
      if(thumbnail.value.path.isNotEmpty){
        if(thumbnailLink.value.isNotEmpty){
          bool isSuccess = await CloudinaryNetWork().delete(thumbnailLink.value!, Constant.FILE_TYPE_image);
        }
        Map<String, dynamic> resImg = await CloudinaryNetWork().upload(Constant.CLOUDINARY_ADMIN_RECIPE_IMAGE, thumbnail.value, Constant.FILE_TYPE_image);
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
        "description": formController["title"]?.text.toString().trim(),
        "direction": formController["direction"]?.text.toString().trim(),
        "photo":url,
        "mealType":selectedMealType.value,
        "numberOfServing": formController["numberOfServing"]?.text.toString().trim(),
        "foods": myIngredients.toJson(),
        "recipes":[]
      };
      Object obj = jsonEncode(item);
      print(obj);

      NetworkApiService networkApiService = NetworkApiService();

      // loading.value = true;
      http.Response res = await networkApiService.putApi("/meal/update-discover-meal/${mealId.value}", obj);
      // loading.value = false;
      if (res.statusCode == 200) {
        Get.find<DiscoverRecipesController>().getAllMealDiscover();
        Get.back();
      }
    }

  }
  Future<void> deleteDiscoverMeal() async {
    Get.defaultDialog(
      radius: 8,
      title: "Delete this item?",
      middleText: "If delete, you can not recover this data.",
      textConfirm: "Delete",
      textCancel: "Dismiss",
      onConfirm: () async {
        NetworkApiService networkApiService = NetworkApiService();
          http.Response res = await networkApiService.deleteApi("/meal/delete-discover-meal/${mealId.value}");
          if (res.statusCode == 200) {
            Get.find<DiscoverRecipesController>().getAllMealDiscover();
            Get.close(1);
            Get.back();
          }
      },
    );
  }
}
