import 'dart:convert';
import 'package:do_an_2/model/logDiaryDTO.dart';
import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:do_an_2/views/user/food_overview/pick_image/pick_image_controller.dart';
import 'package:intl/intl.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/add_discover_recipe/add_discover_recipe_controller.dart';
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
  final List<String> itemsMeal = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];
  var isShow = false.obs;
  var type = "".obs;

  var selectedMeal = "Breakfast".obs;
  RxMap<String, Val> errors = {
    "servingSize": Val(false, ""),
    "numberOfServing": Val(false, ""),
  }.obs;

  FoodDTO fdto = FoodDTO('foodId', 'foodName', 'description', 1, 1, null);
  RecipeDTO rdto = RecipeDTO('recipeId', 'title', 2, null);
  LogDiaryDTO logDiaryDTO = LogDiaryDTO('logDiaryItemId', 'logDiaryType', 0, null, null);

  var diaryLogType = "".obs;
  var indexV = "".obs;
  var fid = "".obs;
  var fname = "".obs;
  var fdes = "".obs;
  late DateTime sltDate = DateTime.now();
  @override
  void onInit() {
    super.onInit();
    type.value = Get.parameters["type"]!;

    print(type.value);
    validate = {
      "servingSize": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Required a number",
      },
      "numberOfServing": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Required a number",
      },
    };
    if (Get.parameters["type"] == "fromIngredientPage" || Get.parameters["type"] == "fromIngredientPickImgPage") {
      AddRecipeController f = Get.find<AddRecipeController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.foods.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      double cv = (fdto.numberOfServing ?? 1) * (fdto.servingSize ?? 100) / 100;
      setData(cv);
    } else if (Get.parameters["type"] == "fromPickImgIngredientPage") {
      PickImageController f = Get.find<PickImageController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.myPredictFoods.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      double cv = (fdto.numberOfServing ?? 1) * (fdto.servingSize ?? 100) / 100;
      setData(cv);
    } else if (Get.parameters["type"] == "fromIngredientAdminPage") {
      AddDiscoverRecipeController f = Get.find<AddDiscoverRecipeController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.foods.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      double cv = (fdto.numberOfServing ?? 1) * (fdto.servingSize ?? 100) / 100;
      setData(cv);
    } else if (Get.parameters["type"] == "fromAddRecipePage") {
      AddRecipeController f = Get.find<AddRecipeController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.myIngredients.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      setData(1);
    } else if (Get.parameters["type"] == "fromUpdateDisRecipePage") {
      AddDiscoverRecipeController f = Get.find<AddDiscoverRecipeController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.myIngredients.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      double cv = (fdto.numberOfServing ?? 1) * (fdto.servingSize ?? 100) / 100;
      setData(cv);
    } else if (Get.parameters["type"] == "fromAddMealItemFoodPage") {
      AddMealItemController f = Get.find<AddMealItemController>();
      indexV.value = Get.parameters["index"]!;

      fdto = f.myFood.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";

      setData(1);
    } else if (Get.parameters["type"] == "fromAddMealItemRecipePage") {
      AddMealItemController f = Get.find<AddMealItemController>();
      indexV.value = Get.parameters["index"]!;

      rdto = f.myRecipe.elementAt(int.parse(indexV.value));
      fname.value = rdto.title!;
      fid.value = rdto.recipeId!;
      fdes.value = rdto.getStringDescription();
      formController["numberOfServing"]!.text = "1";
      formController["servingSize"]!.text = "100.0";
      setData(1);
    } else if (Get.parameters["type"] == "updateLogRecipe") {
      indexV.value = Get.parameters['index']!;
      DiaryController f = Get.find<DiaryController>();
      diaryLogType.value = Get.parameters["diaryType"]!;
      if (diaryLogType == "breakfast") {
        LogDiaryDTO l = f.breakfast.elementAt(int.parse(indexV.value));
        logDiaryDTO = l;
        rdto = l.foodLogItem!.recipe!;
        formController["numberOfServing"]!.text = "${l.foodLogItem!.numberOfServing!}";
        selectedMeal.value = "Breakfast";
      }
      if (diaryLogType == "lunch") {
        LogDiaryDTO l = f.lunch.elementAt(int.parse(indexV.value));
        logDiaryDTO = l;
        rdto = l.foodLogItem!.recipe!;
        formController["numberOfServing"]!.text = "${l.foodLogItem!.numberOfServing!}";
        selectedMeal.value = "Lunch";
      }
      if (diaryLogType == "dinner") {
        LogDiaryDTO l = f.dinner.elementAt(int.parse(indexV.value));
        logDiaryDTO = l;
        rdto = l.foodLogItem!.recipe!;
        formController["numberOfServing"]!.text = "${l.foodLogItem!.numberOfServing!}";
        selectedMeal.value = "Dinner";
      }
      if (diaryLogType == "snack") {
        LogDiaryDTO l = f.snack.elementAt(int.parse(indexV.value));
        logDiaryDTO = l;
        rdto = l.foodLogItem!.recipe!;
        formController["numberOfServing"]!.text = "${l.foodLogItem!.numberOfServing!}";
        selectedMeal.value = "Snack";
      }
      fname.value = rdto.title!;
      fid.value = rdto.recipeId!;
      sltDate = f.sltDate;
      fdes.value = rdto.getStringDescription();
      formController["servingSize"]!.text = "100";
      setData(double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0") ?? 1);
    } else if (Get.parameters["type"] == "updateLogFood") {
      indexV.value = Get.parameters['index']!;
      DiaryController f = Get.find<DiaryController>();
      diaryLogType.value = Get.parameters["diaryType"]!;
      if (diaryLogType == "breakfast") {
        LogDiaryDTO l = f.breakfast.elementAt(int.parse(indexV.value));
        logDiaryDTO = l;
        fdto = l.foodLogItem!.food!;
        formController["numberOfServing"]!.text = "${l.foodLogItem!.numberOfServing!}";
        selectedMeal.value = "Breakfast";
      }
      if (diaryLogType == "lunch") {
        LogDiaryDTO l = f.lunch.elementAt(int.parse(indexV.value));
        logDiaryDTO = l;
        fdto = l.foodLogItem!.food!;
        formController["numberOfServing"]!.text = "${l.foodLogItem!.numberOfServing!}";
        selectedMeal.value = "Lunch";
      }
      if (diaryLogType == "dinner") {
        LogDiaryDTO l = f.dinner.elementAt(int.parse(indexV.value));
        logDiaryDTO = l;
        fdto = l.foodLogItem!.food!;
        formController["numberOfServing"]!.text = "${l.foodLogItem!.numberOfServing!}";
        selectedMeal.value = "Dinner";
      }
      if (diaryLogType == "snack") {
        LogDiaryDTO l = f.snack.elementAt(int.parse(indexV.value));
        logDiaryDTO = l;
        fdto = l.foodLogItem!.food!;
        formController["numberOfServing"]!.text = "${l.foodLogItem!.numberOfServing!}";
        selectedMeal.value = "Snack";
      }
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      sltDate = f.sltDate;
      formController["servingSize"]!.text = "${fdto.servingSize}";

      setData(double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0") ?? 1);
    } else if (Get.parameters["type"] == "fromPickImgRecipePage") {
      FoodOverviewController f = Get.find<FoodOverviewController>();
      indexV.value = Get.parameters["index"]!;
      PickImageController pic = Get.find<PickImageController>();
      selectedMeal.value = f.selectedMeal.value;
      rdto = pic.myPredictRecipes.elementAt(int.parse(indexV.value));
      fname.value = rdto.title!;
      fid.value = rdto.recipeId!;
      fdes.value = rdto.getStringDescription();
      formController["numberOfServing"]!.text = "1";
      formController["servingSize"]!.text = "100";
      setData(1);
    } else {
      showData();
    }
  }

  void showData() {
    FoodOverviewController f = Get.arguments;
    indexV.value = Get.parameters["index"]!;
    selectedMeal.value = f.selectedMeal.value;
    if (Get.parameters["type"] == "fromMyRecipePage") {
      rdto = f.myRecipe.elementAt(int.parse(indexV.value));
      fname.value = rdto.title!;
      fid.value = rdto.recipeId!;
      fdes.value = rdto.getStringDescription();
      formController["numberOfServing"]!.text = "1";
      formController["servingSize"]!.text = "100";
      setData(1);
    } else {
      fdto = f.myFood.elementAt(int.parse(indexV.value));
      fname.value = fdto.foodName!;
      fid.value = fdto.foodId!;
      fdes.value = fdto.getStringDescription();
      formController["numberOfServing"]!.text = "1";
      formController["servingSize"]!.text = "${fdto.servingSize}";
      double cv = (fdto.numberOfServing ?? 1) * (fdto.servingSize ?? 100) / 100;
      setData(1);
    }
  }

  void onChangeSize(String vl) {
    // double nos = double.tryParse(formController["numberOfServing"]!.text.toString().trim())??1;
    // double ss = double.tryParse(formController["servingSize"]!.text.toString().trim())??100;
    // double multiply = nos*ss/100;
    if (Get.parameters["type"] == "fromAddRecipePage") {
      double? d = double.tryParse(formController["numberOfServing"]!.text.toString().trim());
      setData(d! / fdto.numberOfServing!);
    } else {
      setData(double.tryParse(formController["numberOfServing"]!.text.toString().trim()) ?? 1);
    }
  }

  void setData(double i) {
    print(i);
    if (Get.parameters["type"] == "fromMyRecipePage" ||
        Get.parameters["type"] == "fromAddMealItemRecipePage" ||
        Get.parameters["type"] == "updateLogRecipe" ||
        Get.parameters["type"] == "fromPickImgRecipePage") {
      var item = {
        "calories": double.parse(rdto.getCaloriesStr()),
        "fat_total_g": double.parse(rdto.getFatTotalStr()),
        "fat_saturated_g": double.parse(rdto.getFatSatStr()),
        "protein_g": double.parse(rdto.getProStr()),
        "sodium_mg": double.parse(rdto.getSodiStr()),
        "potassium_mg": double.parse(rdto.getPotaStr()),
        "cholesterol_mg": double.parse(rdto.getCholesterolStr()),
        "carbohydrates_total_g": double.parse(rdto.getCarbStr()),
        "fiber_g": double.parse(rdto.getFiberStr()),
        "sugar_g": double.parse(rdto.getSugarStr())
      };

      formController["calories"]!.text = (item["calories"]! * i).toStringAsFixed(2);
      formController["fat_total_g"]!.text = (item["fat_total_g"]! * i).toStringAsFixed(2);
      formController["fat_saturated_g"]!.text = (item["fat_saturated_g"]! * i).toStringAsFixed(2);
      formController["protein_g"]!.text = (item["protein_g"]! * i).toStringAsFixed(2);
      formController["sodium_mg"]!.text = (item["sodium_mg"]! * i).toStringAsFixed(2);
      formController["potassium_mg"]!.text = (item["potassium_mg"]! * i).toStringAsFixed(2);
      formController["cholesterol_mg"]!.text = (item["cholesterol_mg"]! * i).toStringAsFixed(2);
      formController["carbohydrates_total_g"]!.text = (item["carbohydrates_total_g"]! * i).toStringAsFixed(2);
      formController["fiber_g"]!.text = (item["fiber_g"]! * i).toStringAsFixed(2);
      formController["sugar_g"]!.text = (item["sugar_g"]! * i).toStringAsFixed(2);
    } else {
      double nos = fdto.numberOfServing! * fdto.servingSize! / 100;
      print(nos);

      formController["calories"]!.text = (fdto.nutrition!.elementAt(0).amount * i * nos).toStringAsFixed(2);
      formController["fat_total_g"]!.text = (fdto.nutrition!.elementAt(2).amount * i * nos).toStringAsFixed(2);
      formController["fat_saturated_g"]!.text = (fdto.nutrition!.elementAt(3).amount * i * nos).toStringAsFixed(2);
      formController["protein_g"]!.text = (fdto.nutrition!.elementAt(4).amount * i * nos).toStringAsFixed(2);
      formController["sodium_mg"]!.text = (fdto.nutrition!.elementAt(5).amount * i * nos).toStringAsFixed(2);
      formController["potassium_mg"]!.text = (fdto.nutrition!.elementAt(6).amount * i * nos).toStringAsFixed(2);
      formController["cholesterol_mg"]!.text = (fdto.nutrition!.elementAt(7).amount * i * nos).toStringAsFixed(2);
      formController["carbohydrates_total_g"]!.text = (fdto.nutrition!.elementAt(8).amount * i * nos).toStringAsFixed(2);
      formController["fiber_g"]!.text = (fdto.nutrition!.elementAt(9).amount * i * nos).toStringAsFixed(2);
      formController["sugar_g"]!.text = (fdto.nutrition!.elementAt(10).amount * i * nos).toStringAsFixed(2);
    }
  }

  void logIngredientToRecipe() {
    double nos = double.tryParse(formController["numberOfServing"]!.text.toString().trim()) ?? 1;
    double ss = double.tryParse(formController["servingSize"]!.text.toString().trim()) ?? 100;
    double cv = 100 / (nos * ss);
    print('cv');
    var item = {
      "foodId": fid.value,
      "foodName": fname.value,
      "description": fdes.value,
      "numberOfServing": double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0"),
      "servingSize": double.tryParse(formController["servingSize"]?.text.toString().trim() ?? "0.0"),
      "nutrition": [
        {"nutritionName": "calories", "amount": double.tryParse(formController["calories"]!.text.toString().trim())! * cv, "unit": "cal"},
        {"nutritionName": "serving_size_g", "amount": 100.0, "unit": "g"},
        {"nutritionName": "fat_total_g", "amount": double.tryParse(formController["fat_total_g"]?.text.toString().trim() ?? "0")! * cv, "unit": "g"},
        {
          "nutritionName": "fat_saturated_g",
          "amount": double.tryParse(formController["fat_saturated_g"]?.text.toString().trim() ?? "0")! * cv,
          "unit": "g"
        },
        {"nutritionName": "protein_g", "amount": double.tryParse(formController["protein_g"]?.text.toString().trim() ?? "0")! * cv, "unit": "g"},
        {"nutritionName": "sodium_mg", "amount": double.tryParse(formController["sodium_mg"]?.text.toString().trim() ?? "0")! * cv, "unit": "mg"},
        {
          "nutritionName": "potassium_mg",
          "amount": double.tryParse(formController["potassium_mg"]?.text.toString().trim() ?? "0")! * cv,
          "unit": "mg"
        },
        {
          "nutritionName": "cholesterol_mg",
          "amount": double.tryParse(formController["cholesterol_mg"]?.text.toString().trim() ?? "0")! * cv,
          "unit": "mg"
        },
        {
          "nutritionName": "carbohydrates_total_g",
          "amount": double.tryParse(formController["carbohydrates_total_g"]?.text.toString().trim() ?? "0")! * cv,
          "unit": "g"
        },
        {"nutritionName": "fiber_g", "amount": double.tryParse(formController["fiber_g"]?.text.toString().trim() ?? "0")! * cv, "unit": "g"},
        {"nutritionName": "sugar_g", "amount": double.tryParse(formController["sugar_g"]?.text.toString().trim() ?? "0")! * cv, "unit": "g"}
      ]
    };
    print(item);
    FoodDTO vv = FoodDTO.fromJson(item);
    if (Get.parameters["type"] == "fromUpdateDisRecipePage") {
      Get.find<AddDiscoverRecipeController>().myIngredients[int.parse(indexV.value)] = vv;
      Get.find<AddDiscoverRecipeController>().updateData();
    } else if (Get.parameters["type"] == "fromIngredientAdminPage") {
      Get.find<AddDiscoverRecipeController>().myIngredients.refresh();
      if (Get.find<AddDiscoverRecipeController>().myIngredients.any((element) => element.foodName == vv.foodName)) {
        Get.defaultDialog(
            radius: 8,
            title: "Ingredient is existed",
            middleText: "Ingredient is existed.",
            textConfirm: "Dismiss",
            onConfirm: () {
              Get.close(1);
              return;
            });
      }
      Get.find<AddDiscoverRecipeController>().myIngredients.add(vv);

      Get.find<AddDiscoverRecipeController>().updateData();
    } else if (Get.parameters["type"] == "fromIngredientPickImgPage" || Get.parameters["type"] == "fromPickImgIngredientPage") {
      Get.find<PickImageController>().myFood.refresh();
      Get.find<PickImageController>().myFood.add(vv);
      Get.find<PickImageController>().updateData();
    } else {
      Get.find<AddRecipeController>().myIngredients.refresh();
      if (Get.parameters["type"] == "fromIngredientPage") {
        if (Get.find<AddRecipeController>().myIngredients.any((element) => element.foodName == vv.foodName)) {
          Get.defaultDialog(
              radius: 8,
              title: "Ingredient is existed",
              middleText: "Ingredient is existed.",
              textConfirm: "Dismiss",
              onConfirm: () {
                Get.close(1);
                return;
              });
        }
        Get.find<AddRecipeController>().myIngredients.add(vv);
      }

      if (Get.parameters["type"] == "fromAddRecipePage") {
        Get.find<AddRecipeController>().myIngredients[int.parse(indexV.value)] = vv;
      }
      Get.find<AddRecipeController>().update();
      Get.find<AddRecipeController>().updateData();
    }

    Get.back();
  }

  void logMealItemToMeal() {
    MealController m = Get.find<MealController>();
    if (type.value == "fromAddMealItemFoodPage") {
      FoodDTO newFood = fdto;
      newFood.numberOfServing = double.tryParse(formController["numberOfServing"]!.text.toString().trim()) ?? 1.0;
      newFood.servingSize = double.tryParse(formController["servingSize"]!.text.toString().trim()) ?? 100;
      m.myFood.refresh();
      m.myFood.add(newFood);
    }
    if (type.value == "fromAddMealItemRecipePage") {
      RecipeDTO newRecipe = rdto;
      newRecipe.numberOfServing = (double.tryParse(formController["numberOfServing"]!.text.toString().trim()) ?? 1.0) / rdto.numberOfServing!;
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
        if (Get.parameters["type"] == "fromMyRecipePage") {
          http.Response res =
              await networkApiService.deleteApi("/foods/${Get.find<FoodOverviewController>().loginResponse.userId}/deleteRecipe/${fid.value}");
          if (res.statusCode == 200) {
            Get.find<FoodOverviewController>().getAllRecipe();
            Get.close(1);

            Get.back();
          }
        } else {
          http.Response res =
              await networkApiService.deleteApi("/foods/${Get.find<FoodOverviewController>().loginResponse.userId}/deleteFood/${fid.value}");
          if (res.statusCode == 200) {
            Get.find<FoodOverviewController>().getAllFood();
            Get.close(1);

            Get.back();
          }
        }
      },
    );
  }

  Future<void> logFood() async {
    String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(sltDate);
    var item;
    if (Get.parameters["type"] == "fromMyFoodPage") {
      item = {
        "logDiaryId": "",
        "dateLog": formattedDateTime,
        "foodLogItem": {
          "food": fdto.toJson(),
          "numberOfServing": double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0"),
          "foodLogType": "food"
        },
        "logDiaryType": selectedMeal.value
      };
    }
    if (Get.parameters["type"] == "updateLogFood") {
      item = {
        "logDiaryId": logDiaryDTO.logDiaryItemId,
        "dateLog": formattedDateTime,
        "foodLogItem": {
          "food": fdto.toJson(),
          "numberOfServing": double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0"),
          "foodLogType": "food"
        },
        "logDiaryType": selectedMeal.value
      };
    }
    if (Get.parameters["type"] == "fromMyRecipePage" ||Get.parameters["type"] == "fromPickImgRecipePage" ) {
      item = {
        "logDiaryId": "",
        "dateLog": formattedDateTime,
        "foodLogItem": {
          "recipe": rdto.toJson(),
          "numberOfServing": double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0"),
          "foodLogType": "recipe"
        },
        "logDiaryType": selectedMeal.value
      };
    }
    if (Get.parameters["type"] == "updateLogRecipe") {
      item = {
        "logDiaryId": logDiaryDTO.logDiaryItemId,
        "dateLog": formattedDateTime,
        "foodLogItem": {
          "recipe": rdto.toJson(),
          "numberOfServing": double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0"),
          "foodLogType": "recipe"
        },
        "logDiaryType": selectedMeal.value
      };
    }
    Object obj = jsonEncode(item);

    if (Get.parameters["type"] == "updateLogRecipe" || Get.parameters["type"] == "updateLogFood") {
      NetworkApiService networkApiService = NetworkApiService();
      DiaryController clr = Get.find<DiaryController>();

      http.Response res = await networkApiService.postApi("/log-diary/update-diary/${clr.loginResponse.userId}", obj);
      logDiaryDTO.foodLogItem?.numberOfServing = double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0");

      if (res.statusCode == 200) {
        DiaryController diaryController = Get.find<DiaryController>();
        if (diaryLogType.value == "breakfast") {
          diaryController.breakfast.removeAt(int.parse(indexV.value));
        } else if (diaryLogType.value == "lunch") {
          diaryController.lunch.removeAt(int.parse(indexV.value));
        } else if (diaryLogType.value == "dinner") {
          diaryController.dinner.removeAt(int.parse(indexV.value));
        } else if (diaryLogType.value == "snack") {
          diaryController.snack.removeAt(int.parse(indexV.value));
        }
        if (selectedMeal.value == "Breakfast") {
          diaryController.breakfast.add(logDiaryDTO);
        } else if (selectedMeal.value == "Lunch") {
          diaryController.lunch.add(logDiaryDTO);
        } else if (selectedMeal.value == "Dinner") {
          diaryController.dinner.add(logDiaryDTO);
        } else if (selectedMeal.value == "Snack") {
          diaryController.snack.add(logDiaryDTO);
        }
      }
      Get.close(1);
    } else {
      NetworkApiService networkApiService = NetworkApiService();
      FoodOverviewController clr = Get.find<FoodOverviewController>();
      http.Response res = await networkApiService.postApi("/log-diary/add-log/${clr.loginResponse.userId}", obj);

      if (res.statusCode == 200) {
        LogDiaryDTO logDiaryDTO = LogDiaryDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
        DiaryController diaryController = Get.find<DiaryController>();
        if (selectedMeal.value == "Breakfast") {
          diaryController.breakfast.add(logDiaryDTO);
        } else if (selectedMeal.value == "Lunch") {
          diaryController.lunch.add(logDiaryDTO);
        } else if (selectedMeal.value == "Dinner") {
          diaryController.dinner.add(logDiaryDTO);
        } else if (selectedMeal.value == "Snack") {
          diaryController.snack.add(logDiaryDTO);
        }
      }
      Get.close(2);
    }
  }
}
