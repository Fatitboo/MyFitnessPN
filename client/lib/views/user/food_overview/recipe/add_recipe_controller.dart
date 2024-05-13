import 'dart:convert';

import 'package:do_an_2/model/recipeDTO.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/network/network_api_service.dart';
import '../../../../model/foodDTO.dart';
import '../../../../model/historyDTO.dart';
import '../../../../res/service/remote_service.dart';
import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';
import 'package:http/http.dart' as http;

import '../log_food/log_food_controller.dart';

class AddRecipeController extends GetxController {
  TextEditingController txtSearch = TextEditingController();
  var isShow = false.obs;

  Map<String, TextEditingController> formController = {
    "title": TextEditingController(),
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
  RxMap<String, Val> errors = {
    "title": Val(false, ""),
    "numberOfServing": Val(false, ""),
  }.obs;
  List<FoodDTO> foods = [];
  RxList search = [].obs;
  RxList myHistory = <HistoryDTO>[].obs;
  RxList<FoodDTO> myIngredients = <FoodDTO>[].obs;
  var indexV = "".obs;
  var recipeId = "".obs;
  var type = "".obs;

  @override
  void onInit() {
    super.onInit();
    formController["numberOfServing"]!.text = "${1.0}";
    type.value = Get.parameters["type"]??"";
    validate = {"title": {ERROR_TYPE.require: "Food Name is required"}, "numberOfServing": {ERROR_TYPE.require: "Number Of Serving is required", ERROR_TYPE.number: "Number Of Serving must be a number",}};
    if (type.value == "edit"){
      FoodOverviewController f = Get.find<FoodOverviewController>();
      indexV.value = Get.parameters["index"]!;
      RecipeDTO r =  f.myRecipe.elementAt(int.parse(indexV.value));
      List<FoodDTO> fl = r.foods!;
      myIngredients.assignAll(fl);
      recipeId.value = r.recipeId!;
      formController["title"]!.text = "${r.title}";
      formController["numberOfServing"]!.text = "${r.numberOfServing}";


    }

    updateData();
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
      double cv = (f.numberOfServing??1)*(f.servingSize??100)/100;
      print(cv);
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
    double i = double.parse(formController["numberOfServing"]!.text );
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

  Future<void> handleAddRecipe() async {
    errors.value = Validator.ValidateForm(validate, formController);
    var result = errors.values
        .toList()
        .firstWhere((e) => e.isError, orElse: () => Val(false, ""));
    Object obj;
    Map<String, dynamic> item;
    if (!result.isError) {

      item = {
        "recipeId": "",
        "title": formController["title"]?.text.toString().trim(),
        "numberOfServing": formController["numberOfServing"]?.text.toString().trim(),
        "foods": myIngredients.toJson()
      };
      Object obj = jsonEncode(item);
      print(obj);

      NetworkApiService networkApiService = NetworkApiService();
      FoodOverviewController clr = Get.find<FoodOverviewController>();
      // loading.value = true;
      http.Response res = await networkApiService.postApi("/foods/${clr.loginResponse.userId}/createRecipe", obj);
      // loading.value = false;
      if (res.statusCode == 200) {
        clr.myHistory.refresh();

        http.Response res = await networkApiService.getApi("/foods/${clr.loginResponse.userId}/getRecipes");
        // loading.value = false;

        if (res.statusCode == 200) {
          Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));
         
          List<RecipeDTO> rec = List<RecipeDTO>.from(i["recipes"].map((model) => RecipeDTO.fromJson(model))).toList();
          clr.myRecipe.refresh();
          clr.myRecipe = rec.obs;

          clr.update();

        }
        Get.back();
      }
    }
  }
  Future<void> handleUpdateRecipe() async {
    errors.value = Validator.ValidateForm(validate, formController);
    var result = errors.values
        .toList()
        .firstWhere((e) => e.isError, orElse: () => Val(false, ""));
    Object obj;
    Map<String, dynamic> item;
    if (!result.isError) {
      item = {
        "recipeId": recipeId.value,
        "title": formController["title"]?.text.toString().trim(),
        "numberOfServing": formController["numberOfServing"]?.text.toString().trim(),
        "foods": myIngredients.toJson()
      };
      Object obj = jsonEncode(item);
      print(obj);

      NetworkApiService networkApiService = NetworkApiService();
      FoodOverviewController clr = Get.find<FoodOverviewController>();
      // loading.value = true;
      print("edit");
      http.Response res = await networkApiService.postApi("/foods/${clr.loginResponse.userId}/updateRecipe", obj);
      // loading.value = false;
      if (res.statusCode == 200) {
        clr.myRecipe.refresh();
        clr.myHistory.refresh();

        http.Response res = await networkApiService.getApi("/foods/${clr.loginResponse.userId}/getRecipes");
        // loading.value = false;

        if (res.statusCode == 200) {
          Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));

          List<RecipeDTO> rec = List<RecipeDTO>.from(i["recipes"].map((model) => RecipeDTO.fromJson(model))).toList();

          clr.myRecipe.value = rec.obs;

          clr.update();

        }

        Get.back();
      }  else {
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }

    }
  }

}
