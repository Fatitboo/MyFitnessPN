
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:do_an_2/views/user/food_overview/meal/add_meal_item/add_meal_item_controller.dart';
import 'package:do_an_2/views/user/food_overview/meal/meal_controller.dart';
import 'package:do_an_2/views/user/food_overview/recipe/add_recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../../data/network/network_api_service.dart';
import '../../../../model/foodDTO.dart';
import '../../../../model/recipeDTO.dart';
import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';

class LogFoodController extends GetxController {
  late final NetworkApiService networkApiService;
  Map<String, TextEditingController> formController = {
    "servingSize": TextEditingController(),
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
  final List<String> itemsMeal = ['Breakfast', 'Lunch', 'Dinner', 'Snack',];
  var isShow = false.obs;
  var type = "".obs;

  var selectedMeal = "Breakfast".obs;
  RxMap<String, Val> errors = {"servingSize": Val(false, ""), "numberOfServing": Val(false, ""),}.obs;

  FoodDTO fdto = FoodDTO('foodId', 'foodName', 'description', 1, 1, null);
  RecipeDTO rdto = RecipeDTO('recipeId', 'title', 2, null);

  var indexV = "".obs;
  var fid = "".obs;
  var fname = "".obs;
  var fdes = "".obs;
  @override
  void onInit() {
    super.onInit();
    type.value = Get.parameters["type"]!;
    print(type.value);
    validate = {"servingSize": {ERROR_TYPE.require: "Required", ERROR_TYPE.number: "Required a number",}, "numberOfServing": {ERROR_TYPE.require: "Required", ERROR_TYPE.number: "Required a number",},};
    if (Get.parameters["type"] == "fromIngredientPage" ) {
      AddRecipeController f = Get.find<AddRecipeController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.foods.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      double cv = (fdto.numberOfServing??1)*(fdto.servingSize??100)/100;
      setData(cv);
    }
    else if (Get.parameters["type"] == "fromAddRecipePage"){
      AddRecipeController f = Get.find<AddRecipeController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.myIngredients.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      double cv = (fdto.numberOfServing??1)*(fdto.servingSize??100)/100;
      setData(cv);
    }
    else if (Get.parameters["type"] == "fromMyRecipePage"){
      FoodOverviewController f = Get.find<FoodOverviewController>();
      indexV.value = Get.parameters["index"]!;

      rdto = f.myRecipe.elementAt(int.parse(indexV.value));
      fname.value = rdto.title!;
      fid.value = rdto.recipeId!;
      fdes.value = rdto.getStringDescription();
      formController["numberOfServing"]!.text = "${rdto.numberOfServing}";
      formController["servingSize"]!.text = "100";
      double cv = (rdto.numberOfServing??1);
      setData(cv);
    }
    else if (Get.parameters["type"] == "fromAddMealItemFoodPage"){
      AddMealItemController f = Get.find<AddMealItemController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.myFood.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      double cv = (fdto.numberOfServing??1)*(fdto.servingSize??100)/100;
      setData(cv);
    }
    else if (Get.parameters["type"] == "fromAddMealItemRecipePage"){
      AddMealItemController f = Get.find<AddMealItemController>();
      indexV.value = Get.parameters["index"]!;

      rdto = f.myRecipe.elementAt(int.parse(indexV.value));
      fname.value = rdto.title!;
      fid.value = rdto.recipeId!;
      fdes.value = rdto.getStringDescription();
      formController["numberOfServing"]!.text = "${rdto.numberOfServing}";
      formController["servingSize"]!.text = "100.0";
      double cv = (rdto.numberOfServing??1);
      setData(cv);
    }
    else {
      showData();
    }
  }

  void showData() {
    FoodOverviewController f = Get.arguments;
    indexV.value = Get.parameters["index"]!;
    if (Get.parameters["type"] == "fromMyRecipePage"
    ||Get.parameters["type"] == "fromAddRecipePage"){
      rdto = f.myRecipe.elementAt(int.parse(indexV.value));
      fname.value = rdto.title!;
      fid.value = rdto.recipeId!;
      fdes.value = rdto.getStringDescription();
      formController["numberOfServing"]!.text = "${rdto.numberOfServing}";
      formController["servingSize"]!.text = "100";
      setData(rdto.numberOfServing??1);

    }else{
      fdto = f.myFood.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";
      double cv = (fdto.numberOfServing??1)*(fdto.servingSize??100)/100;
      setData(cv);

    }


  }

  void onChangeSize(String vl) {
    double nos = double.tryParse(formController["numberOfServing"]!.text.toString().trim())??1;
    double ss = double.tryParse(formController["servingSize"]!.text.toString().trim())??100;
    double multiply = nos*ss/100;
    setData(multiply);
  }

  void setData(double i) {
    if (Get.parameters["type"] == "fromMyRecipePage"
    ||Get.parameters["type"] == "fromAddMealItemRecipePage"
    ){
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
      for (FoodDTO f in rdto.foods??[]) {
        double cv = (f.numberOfServing??1)*(f.servingSize??100)/100;
        item["calories"] = item["calories"]! + f.nutrition!.elementAt(0).amount*cv ?? 0.0;
        item["fat_total_g"] = item["fat_total_g"]! + f.nutrition!.elementAt(2).amount*cv ?? 0.0;
        item["fat_saturated_g"] = item["fat_saturated_g"]! + f.nutrition!.elementAt(3).amount*cv ?? 0.0;
        item["protein_g"] = item["protein_g"]! + f.nutrition!.elementAt(4).amount*cv ?? 0.0;
        item["sodium_mg"] = item["sodium_mg"]! + f.nutrition!.elementAt(5).amount*cv ?? 0.0;
        item["potassium_mg"] = item["potassium_mg"]! + f.nutrition!.elementAt(6).amount*cv ?? 0.0;
        item["cholesterol_mg"] = item["cholesterol_mg"]! + f.nutrition!.elementAt(7).amount *cv?? 0.0;
        item["carbohydrates_total_g"] = item["carbohydrates_total_g"]! + f.nutrition!.elementAt(8).amount*cv ?? 0.0;
        item["fiber_g"] = item["fiber_g"]! + f.nutrition!.elementAt(9).amount*cv ?? 0.0;
        item["sugar_g"] = item["sugar_g"]! + f.nutrition!.elementAt(10).amount*cv ?? 0.0;
      }
      formController["calories"]!.text = "${item["calories"]!* i}";
      formController["fat_total_g"]!.text = "${item["fat_total_g"]!* i}";
      formController["fat_saturated_g"]!.text = "${item["fat_saturated_g"]!* i}";
      formController["protein_g"]!.text = "${item["protein_g"]!* i}";
      formController["sodium_mg"]!.text = "${item["sodium_mg"]!* i}";
      formController["potassium_mg"]!.text = "${item["potassium_mg"]!* i}";
      formController["cholesterol_mg"]!.text = "${item["cholesterol_mg"]!* i}";
      formController["carbohydrates_total_g"]!.text = "${item["carbohydrates_total_g"]!* i}";
      formController["fiber_g"]!.text = "${item["fiber_g"]!* i}";
      formController["sugar_g"]!.text = "${item["sugar_g"]!* i}";
    }
    else{

      formController["calories"]!.text = "${fdto.nutrition!.elementAt(0).amount * i}";
      formController["fat_total_g"]!.text = "${fdto.nutrition!.elementAt(2).amount * i}";
      formController["fat_saturated_g"]!.text = "${fdto.nutrition!.elementAt(3).amount * i}";
      formController["protein_g"]!.text = "${fdto.nutrition!.elementAt(4).amount * i}";
      formController["sodium_mg"]!.text = "${fdto.nutrition!.elementAt(5).amount * i}";
      formController["potassium_mg"]!.text = "${fdto.nutrition!.elementAt(6).amount * i}";
      formController["cholesterol_mg"]!.text = "${fdto.nutrition!.elementAt(7).amount * i}";
      formController["carbohydrates_total_g"]!.text = "${fdto.nutrition!.elementAt(8).amount * i}";
      formController["fiber_g"]!.text = "${fdto.nutrition!.elementAt(9).amount * i}";
      formController["sugar_g"]!.text = "${fdto.nutrition!.elementAt(10).amount * i}";
    }

  }


  void logIngredientToRecipe() {
    double nos = double.tryParse(formController["numberOfServing"]!.text.toString().trim())??1;
    double ss = double.tryParse(formController["servingSize"]!.text.toString().trim())??100;
    double cv = 100/(nos*ss);
    print(cv);
    var item = {
      "foodId": fid.value,
      "foodName": fname.value,
      "description": fdes.value,
      "numberOfServing": double.tryParse(formController["numberOfServing"]?.text.toString().trim()??"0.0"),
      "servingSize": double.tryParse(formController["servingSize"]?.text.toString().trim()??"0.0"),
      "nutrition": [
        {
          "nutritionName": "calories",
          "amount": double.tryParse(formController["calories"]!.text.toString().trim())!*cv,
          "unit": "cal"
        },
        {
          "nutritionName": "serving_size_g",
          "amount": 100.0,
          "unit": "g"
        },
        {
          "nutritionName": "fat_total_g",
          "amount": double.tryParse(formController["fat_total_g"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "g"
        },
        {
          "nutritionName": "fat_saturated_g",
          "amount": double.tryParse(formController["fat_saturated_g"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "g"
        },
        {
          "nutritionName": "protein_g",
          "amount": double.tryParse(formController["protein_g"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "g"
        },
        {
          "nutritionName": "sodium_mg",
          "amount": double.tryParse(formController["sodium_mg"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "mg"
        },
        {
          "nutritionName": "potassium_mg",
          "amount": double.tryParse(formController["potassium_mg"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "mg"
        },
        {
          "nutritionName": "cholesterol_mg",
          "amount": double.tryParse(formController["cholesterol_mg"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "mg"
        },
        {
          "nutritionName": "carbohydrates_total_g",
          "amount": double.tryParse(formController["carbohydrates_total_g"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "g"
        },
        {
          "nutritionName": "fiber_g",
          "amount": double.tryParse(formController["fiber_g"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "g"
        },
        {
          "nutritionName": "sugar_g",
          "amount": double.tryParse(formController["sugar_g"]?.text.toString().trim() ?? "0")!*cv,
          "unit": "g"
        }
      ]
    };
    FoodDTO vv = FoodDTO.fromJson(item);
    Get.find<AddRecipeController>().myIngredients.refresh();

    if(Get.parameters["type"] == "fromIngredientPage"){
      Get.find<AddRecipeController>().myIngredients.add(vv);
    }
    if(Get.parameters["type"] == "fromAddRecipePage"){
      Get.find<AddRecipeController>().myIngredients[int.parse(indexV.value)] = vv;
    }
    Get.find<AddRecipeController>().update();
    Get.find<AddRecipeController>().updateData();
    Get.back();

  }
  void logMealItemToMeal() {

    MealController m = Get.find<MealController>();
    if (type.value == "fromAddMealItemFoodPage"){

      FoodDTO newFood = fdto;
      newFood.numberOfServing = double.tryParse(formController["numberOfServing"]!.text.toString().trim())??1.0;
      newFood.servingSize = double.tryParse(formController["servingSize"]!.text.toString().trim())??100;
      m.myFood.refresh();
      m.myFood.add(newFood);
    }
    if (type.value == "fromAddMealItemRecipePage"){
      RecipeDTO newRecipe = rdto;
      newRecipe.numberOfServing = double.tryParse(formController["numberOfServing"]!.text.toString().trim())??1.0;
      m.myRecipe.refresh();
      m.myRecipe.add(newRecipe);
    }
    m.updateData();
    m.update();
    Get.back();

  }

  Future<void> deleteItem() async {
    Get.defaultDialog(
      radius: 8,
      title: "Delete this item?",
      middleText: "If delete, you can not recover this data.",
      textConfirm: "Delete",
      textCancel: "Dismiss",
      onConfirm: () async {
        NetworkApiService networkApiService = NetworkApiService();
        if (Get.parameters["type"] == "fromMyRecipePage"){
          http.Response res = await networkApiService.deleteApi("/foods/${Get.find<FoodOverviewController>().loginResponse.userId}/deleteRecipe/${fid.value}");
          if (res.statusCode == 200) {
            Get.find<FoodOverviewController>().getAllRecipe();
            Get.close(1);

            Get.back();
          }
        }else{
          http.Response res = await networkApiService.deleteApi("/foods/${Get.find<FoodOverviewController>().loginResponse.userId}/deleteFood/${fid.value}");
          if (res.statusCode == 200) {
            Get.find<FoodOverviewController>().getAllFood();
            Get.close(1);

            Get.back();
          }
        }

      },
    );
  }
}
