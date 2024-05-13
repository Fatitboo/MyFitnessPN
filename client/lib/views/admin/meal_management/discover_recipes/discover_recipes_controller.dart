import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:do_an_2/model/foodCategoryDTO.dart';
import 'package:do_an_2/model/mealByCategory.dart';
import 'package:do_an_2/model/mealDTO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../data/network/network_api_service.dart';
import '../../../../res/service/remote_service.dart';


class DiscoverRecipesController extends GetxController{
  Rx<bool> loading = false.obs;
  TextEditingController txtSearch = TextEditingController();
  Rx<MealCategoryDTO> selectedMealCategory = MealCategoryDTO.init().obs;
  late final NetworkApiService networkApiService = NetworkApiService();
  Rx<Offset> tapPosition = Offset.zero.obs;
  RxList listMeal = [].obs;
  RxList listMealByCategory = [].obs;
  var typeNav = "".obs;
  @override
  void onInit() {
    super.onInit();
    typeNav.value = Get.parameters["type"]??"";
    getAllMealDiscover();

  }
  void getAllMealDiscover() async{
    loading.value = true;
    http.Response res = await networkApiService.getApi("/meal");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<MealDTO> meals = List<MealDTO>.from(i.map((model)=> MealDTO.fromJson(model))).toList();
      List<MealByCategoryDTO> mealsByCate = [];
      listMeal.value = meals;
      for (var element in meals) {
        if(mealsByCate.isEmpty){
          mealsByCate.add(MealByCategoryDTO(element.mealType, [element]));
        }else{
          var isExist =  mealsByCate.firstWhereOrNull((e) => e.mealType==element.mealType);
          if(isExist != null){
            isExist.meals?.add(element);
          }else{
            mealsByCate.add(MealByCategoryDTO(element.mealType, [element]));
          }
        }
      }
      listMealByCategory.value = mealsByCate;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  void getDiscoverRecipeFromApi(String queryString) async {
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
      List<MealDTO> meals = await RemoteService().getDiscoverRecipeFromApi(queryString);
      MealByCategoryDTO mealByCategoryDTO = MealByCategoryDTO("Result from search", meals);
      listMealByCategory.insert(0, mealByCategoryDTO);
      update();
    }
  }


  void resetHis(){
    txtSearch.clear();
    listMealByCategory.removeWhere((element) => element.mealType == "Result from search");
    update();
  }
}