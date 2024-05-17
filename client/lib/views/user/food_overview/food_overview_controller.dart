import 'dart:convert';

import 'package:do_an_2/model/foodDTO.dart';
import 'package:do_an_2/model/historyDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';
import 'package:do_an_2/res/service/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/network/network_api_service.dart';
import '../../../model/login_response.dart';
import '../../../model/mealDTO.dart';
import '../../../res/store/storage.dart';
import '../../../res/store/user.dart';

class FoodOverviewController extends GetxController {
  TextEditingController txtSearch = TextEditingController();
  final List<String> itemsMeal = ['Breakfast', 'Lunch', 'Dinner', 'Snack',];
  var selectedMeal = "Breakfast".obs;
  late NetworkApiService networkApiService;
  RxList myFood = [].obs;
  RxList myRecipe = [].obs;
  RxList myMeal = [].obs;
  RxList his = [].obs;
  RxList search = [].obs;
  var title =  " ".obs;
  RxList myHistory = <HistoryDTO>[].obs;

  void onChangeValueDropdownBtn(String value) {selectedMeal.value = value;}

  LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(StorageService.to.getString(STORAGE_USER_PROFILE_KEY)));
  @override
  void onInit() {
    super.onInit();
    networkApiService = NetworkApiService();
    var mealType = Get.arguments["mealType"];
    selectedMeal.value = mealType;

    getAllFood();
    getAllRecipe();
    getAllMeal();
    myHistory.refresh();
    myHistory = his;
    update();
  }

  void getAllFood() async {
    // loading.value = true;
    http.Response res = await networkApiService.getApi("/foods/${loginResponse.userId}/getFood");
    // loading.value = false;

    if (res.statusCode == 200) {
      Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));
      List<FoodDTO> foods = List<FoodDTO>.from(i["foods"].map((model) => FoodDTO.fromJson(model))).toList();
      myFood.value = foods.obs;
      for (FoodDTO f in foods) {
        his.add(HistoryDTO(f.foodId, f.foodName, f.getStringDescription(), "food"));
      }
    } else {
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  void getAllRecipe() async {
    // loading.value = true;
    http.Response res = await networkApiService.getApi("/foods/${loginResponse.userId}/getRecipes");
    // loading.value = false;

    if (res.statusCode == 200) {
      Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));
      List<RecipeDTO> r = List<RecipeDTO>.from(i["recipes"].map((model) => RecipeDTO.fromJson(model))).toList();
      myRecipe.value = r.obs;
      for (RecipeDTO f in r) {
        his.add(HistoryDTO(f.recipeId, f.title, f.getStringDescription(), "recipe"));
      }
    } else {
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  void getAllMeal() async {
    // loading.value = true;
    http.Response res = await networkApiService.getApi("/foods/${loginResponse.userId}/getMeals");
    // loading.value = false;

    if (res.statusCode == 200) {
      Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));
      List<MealDTO> r = List<MealDTO>.from(i["meals"].map((model) => MealDTO.fromJson(model))).toList();
      myMeal.value = r.obs;
      for (MealDTO f in r) {
        his.add(HistoryDTO(f.mealId, f.description, f.getStringDescription(), "meal"));
      }
    } else {
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
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
      List<FoodDTO> foods = await RemoteService().getFoodsFromApi(queryString);

      for (FoodDTO f in foods) {
        search.add(HistoryDTO(f.foodId, f.foodName, f.getStringDescription(), "food"));
      }
      myHistory.refresh();
      myHistory= search;
      update();
    }
  }


  void resetHis(){
    txtSearch.clear();
    myHistory.refresh();
    myHistory = his;
    update();
  }
}
