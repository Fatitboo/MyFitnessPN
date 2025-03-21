
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:do_an_2/model/foodCategoryDTO.dart';
import 'package:do_an_2/model/mealByCategory.dart';
import 'package:do_an_2/model/mealDTO.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/network/network_api_service.dart';

class MealManagementController extends GetxController{
  Rx<bool> loading = false.obs;
  Rx<MealCategoryDTO> selectedMealCategory = MealCategoryDTO.init().obs;
  late final NetworkApiService networkApiService = NetworkApiService();
  RxList listCategory = [].obs;
  Rx<Offset> tapPosition = Offset.zero.obs;
  RxList listMealByCategory = [].obs;
   @override
  void onInit() {
    super.onInit();


  }
  void getAllMealCategory() async{
    loading.value = true;
    http.Response res = await networkApiService.getApi("/admin/meal-categories");
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      Iterable i = json.decode(utf8.decode(res.bodyBytes));
      List<MealCategoryDTO> mealCategories = List<MealCategoryDTO>.from(i.map((model)=> MealCategoryDTO.fromJson(model))).toList();
      listCategory.value = mealCategories;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
    }
  }

  Future<bool> createMealCategory (Object mealCategory) async{
    loading.value = true;
    http.Response res = await networkApiService.postApi("/admin/meal-categories/create-meal-category", mealCategory);
    loading.value = false;
    if(res.statusCode == HttpStatus.created){
      MealCategoryDTO mealCategoryDTO = MealCategoryDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
      listCategory.add(mealCategoryDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }
  Future<bool> updateMealCategory (Object mealCategory, Map<String, dynamic> objJson) async{
    loading.value = true;
    http.Response res = await networkApiService.putApi("/admin/meal-categories/update-meal-category/${selectedMealCategory.value.mealCategoryId}", mealCategory);
    loading.value = false;
    if(res.statusCode == HttpStatus.ok){
      MealCategoryDTO mealCategoryDTO = MealCategoryDTO.fromJson(objJson);
      print(mealCategoryDTO.mealCategoryId);
      int index = listCategory.indexWhere((element) => element.mealCategoryId == selectedMealCategory.value.mealCategoryId);
      listCategory.removeAt(index);
      listCategory.insert(index, mealCategoryDTO);
      return true;
    }
    else{
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }
  Future<bool> deleteMealCategory (String mealId, int index) async{
    loading.value = true;
    http.Response res = await networkApiService.deleteApi("/admin/meal-categories/delete-meal-category/$mealId");
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
}