import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodOverviewController extends GetxController{
  TextEditingController txtSearch = TextEditingController();
  final List<String> itemsMeal = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];
  var selectedMeal = "Breakfast".obs;
  void onChangeValueDropdownBtn(String value){
    selectedMeal.value = value;
  }

  @override
  void onInit() {

    super.onInit();
  }
  void onClickTopTabItem(int index){
    switch(index){
      case 1:
      // getAllExercise();
        break;
      case 2:
        // getBrowserExercise();
        break;
    }
  }
}