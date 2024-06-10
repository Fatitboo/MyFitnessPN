import 'dart:convert';

import 'package:do_an_2/model/components/nutrition.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/network/network_api_service.dart';
import '../../../../model/foodDTO.dart';
import '../../../../model/historyDTO.dart';
import '../../../../model/logDiaryDTO.dart';
import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';
import '../../diary/diary_controller.dart';

class AddFoodController extends GetxController {
  Map<String, TextEditingController> formController = {
    "water": TextEditingController(),
    "foodName": TextEditingController(),
    "description": TextEditingController(),
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
  RxMap<String, Val> errors = {
    "foodName": Val(false, ""),
    "description": Val(false, ""),
    "servingSize": Val(false, ""),
    "numberOfServing": Val(false, ""),
    "calories": Val(false, ""),
    "fat_total_g": Val(false, ""),
    "fat_saturated_g": Val(false, ""),
    "cholesterol_mg": Val(false, ""),
    "protein_g": Val(false, ""),
    "sodium_mg": Val(false, ""),
    "potassium_mg": Val(false, ""),
    "carbohydrates_total_g": Val(false, ""),
    "fiber_g": Val(false, ""),
    "sugar_g": Val(false, ""),
  }.obs;
  var foodId = "".obs;
  final List<String> itemsMeal = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];
  var title = "".obs;
  var selectedMeal = "Breakfast".obs;
  late FoodDTO fdto;
  var indexV = "".obs;
  late DateTime sltDate = DateTime.now();
  LogDiaryDTO logDiaryDTO = LogDiaryDTO('logDiaryItemId', 'logDiaryType', 0, null, null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var type = Get.parameters["type"];
    title.value = type!;
    if (type == "edit") {
      FoodOverviewController f = Get.find<FoodOverviewController>();
      int index = int.parse(Get.parameters["index"]!);

      fdto = f.myFood.elementAt(index);
      foodId.value = fdto.foodId!;
      formController["foodName"]!.text = "${fdto.foodName}";
      formController["description"]!.text = "${fdto.description}";
      formController["numberOfServing"]!.text = "${fdto.numberOfServing}";
      formController["servingSize"]!.text = "${fdto.servingSize}";
      setData();
    }
    if (type == "Update Log Water") {
      indexV.value = Get.parameters['index']!;
      DiaryController f = Get.find<DiaryController>();
      LogDiaryDTO l = f.water.elementAt(int.parse(indexV.value));
      logDiaryDTO = l;
      formController["water"]!.text = "${l.water}";
      sltDate = f.sltDate;
    }
    validate = {
      "foodName": {ERROR_TYPE.require: "Required"},
      "servingSize": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Required a number",
      },
      "numberOfServing": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Required a number",
      },
      "calories": {
        ERROR_TYPE.require: "Required",
        ERROR_TYPE.number: "Required a number",
      },
      "fat_total_g": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "fat_saturated_g": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "cholesterol_mg": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "protein_g": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "sodium_mg": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "potassium_mg": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "carbohydrates_total_g": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "fiber_g": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "sugar_g": {ERROR_TYPE.optionalAndNumber: "Required a number"},
      "description": {ERROR_TYPE.require: "Required"},
    };
  }

  void setData() {
    double cv = (fdto.numberOfServing ?? 1) * (fdto.servingSize ?? 100) / 100;
    formController["calories"]!.text = "${fdto.nutrition!.elementAt(0).amount * cv}";
    formController["fat_total_g"]!.text = "${fdto.nutrition!.elementAt(2).amount * cv}";
    formController["fat_saturated_g"]!.text = "${fdto.nutrition!.elementAt(3).amount * cv}";
    formController["protein_g"]!.text = "${fdto.nutrition!.elementAt(4).amount * cv}";
    formController["sodium_mg"]!.text = "${fdto.nutrition!.elementAt(5).amount * cv}";
    formController["potassium_mg"]!.text = "${fdto.nutrition!.elementAt(6).amount * cv}";
    formController["cholesterol_mg"]!.text = "${fdto.nutrition!.elementAt(7).amount * cv}";
    formController["carbohydrates_total_g"]!.text = "${fdto.nutrition!.elementAt(8).amount * cv}";
    formController["fiber_g"]!.text = "${fdto.nutrition!.elementAt(9).amount * cv}";
    formController["sugar_g"]!.text = "${fdto.nutrition!.elementAt(10).amount * cv}";
  }

  Future<bool> createFood(Object food, FoodOverviewController clr) async {
    NetworkApiService networkApiService = NetworkApiService();

    http.Response res = await networkApiService.postApi("/foods/${clr.loginResponse.userId}/createFood", food);
    if (res.statusCode == 200) {
      clr.myHistory.refresh();

      http.Response res = await networkApiService.getApi("/foods/${clr.loginResponse.userId}/getFood");
      // loading.value = false;

      if (res.statusCode == 200) {
        Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));

        List<FoodDTO> foods = List<FoodDTO>.from(i["foods"].map((model) => FoodDTO.fromJson(model))).toList();
        clr.myFood.refresh();

        clr.myFood = foods.obs;

        for (FoodDTO f in foods) {
          clr.his.add(HistoryDTO(f.foodId, f.foodName, f.getStringDescription(), "food"));
        }
        clr.myHistory = clr.his;
        clr.update();
      } else {
        Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
        print(resMessage["message"]);
      }
      return true;
    } else {
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }

  Future<bool> updateFood(Object food, FoodOverviewController clr) async {
    NetworkApiService networkApiService = NetworkApiService();

    // loading.value = true;
    http.Response res = await networkApiService.postApi("/foods/${clr.loginResponse.userId}/updateFood", food);
    Map<String, dynamic> js = json.decode(utf8.decode(res.bodyBytes));
    FoodDTO updFood = FoodDTO.fromJson(js["updatedFood"]);
    // loading.value = false;
    if (res.statusCode == 200) {
      clr.myHistory.refresh();

      http.Response res = await networkApiService.getApi("/foods/${clr.loginResponse.userId}/getFood");
      // loading.value = false;

      if (res.statusCode == 200) {
        Map<String, dynamic> i = json.decode(utf8.decode(res.bodyBytes));
        List<FoodDTO> foods = List<FoodDTO>.from(i["foods"].map((model) => FoodDTO.fromJson(model))).toList();
        clr.myFood.refresh();
        clr.myFood.value = foods.obs;
        for (HistoryDTO element in clr.his) {
          if (element.id == foodId.value) {
            element.description = updFood.getStringDescription();
            element.title = updFood.foodName;
          }
        }
        clr.myHistory.refresh();
        clr.myHistory = clr.his;
        clr.update();
      } else {
        Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
        print(resMessage["message"]);
      }
      return true;
    } else {
      Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
      print(resMessage["message"]);
      return false;
    }
  }

  Future<void> handleAddOrUpdateFood() async {
    errors.value = Validator.ValidateForm(validate, formController);
    var result = errors.values.toList().firstWhere((e) => e.isError, orElse: () => Val(false, ""));
    Map<String, Object?> item;
    if (!result.isError) {
      FoodOverviewController f = Get.find<FoodOverviewController>();
      var type = Get.parameters["type"];

      if (type == "add") {
        bool isFoodExist = false;

        for (int i = 0; i < f.myFood.length; i++) {
          if (f.myFood[i].foodName == formController["foodName"]?.text.toString().trim()) {
            isFoodExist = true;
            break;
          }
        }
        if (isFoodExist) {
          Get.defaultDialog(
              radius: 8,
              title: "Food name is existed",
              middleText: "Please enter different name.",
              textConfirm: "Dismiss",
              onConfirm: () {
                Get.close(1);
              });
        } else {
          double nos = double.tryParse(formController["numberOfServing"]!.text.toString().trim()) ?? 1;
          double ss = double.tryParse(formController["servingSize"]!.text.toString().trim()) ?? 100;
          double cv = 100 / (nos * ss);
          item = {
            "foodId": "",
            "foodName": formController["foodName"]?.text.toString().trim(),
            "description": formController["description"]?.text.toString().trim(),
            "numberOfServing": formController["numberOfServing"]?.text.toString().trim(),
            "servingSize": formController["servingSize"]?.text.toString().trim(),
            "nutrition": [
              {"nutritionName": "calories", "amount": double.tryParse(formController["calories"]!.text.toString().trim())! * cv, "unit": "cal"},
              {"nutritionName": "serving_size_g", "amount": "100", "unit": "g"},
              {
                "nutritionName": "fat_total_g",
                "amount": (double.tryParse(formController["fat_total_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
                "unit": "g"
              },
              {
                "nutritionName": "fat_saturated_g",
                "amount": (double.tryParse(formController["fat_saturated_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
                "unit": "g"
              },
              {
                "nutritionName": "protein_g",
                "amount": (double.tryParse(formController["protein_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
                "unit": "g"
              },
              {
                "nutritionName": "sodium_mg",
                "amount": double.tryParse(formController["sodium_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "mg"
              },
              {
                "nutritionName": "potassium_mg",
                "amount": double.tryParse(formController["potassium_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "mg"
              },
              {
                "nutritionName": "cholesterol_mg",
                "amount": double.tryParse(formController["cholesterol_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "mg"
              },
              {
                "nutritionName": "carbohydrates_total_g",
                "amount": double.tryParse(formController["carbohydrates_total_g"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "g"
              },
              {
                "nutritionName": "fiber_g",
                "amount": double.tryParse(formController["fiber_g"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "g"
              },
              {"nutritionName": "sugar_g", "amount": double.tryParse(formController["sugar_g"]?.text.toString().trim() ?? "0") ?? 0 * cv, "unit": "g"}
            ]
          };
          Object obj = jsonEncode(item);
          if (await createFood(obj, f)) {
            Get.back();
          }
        }
      }
      if (type == "edit") {
        bool found = false;
        int index = int.parse(Get.parameters["index"]!);
        for (int i = 0; i < f.myFood.length; i++) {
          if (i == index) {
            continue;
          }
          if (f.myFood[i].foodName == formController["foodName"]?.text.toString().trim()) {
            found = true;
            break;
          }
        }
        if (found) {
          Get.defaultDialog(
              radius: 8,
              title: "Food name is existed",
              middleText: "Please enter different name.",
              textConfirm: "Dismiss",
              onConfirm: () {
                Get.close(1);
              });
        } else {
          double nos = double.tryParse(formController["numberOfServing"]!.text.toString().trim()) ?? 1;
          double ss = double.tryParse(formController["servingSize"]!.text.toString().trim()) ?? 100;
          double cv = 100 / (nos * ss);
          item = {
            "foodId": foodId.value,
            "foodName": formController["foodName"]?.text.toString().trim(),
            "description": formController["description"]?.text.toString().trim(),
            "numberOfServing": formController["numberOfServing"]?.text.toString().trim(),
            "servingSize": formController["servingSize"]?.text.toString().trim(),
            "nutrition": [
              {"nutritionName": "calories", "amount": double.tryParse(formController["calories"]!.text.toString().trim())! * cv, "unit": "cal"},
              {"nutritionName": "serving_size_g", "amount": "100", "unit": "g"},
              {
                "nutritionName": "fat_total_g",
                "amount": (double.tryParse(formController["fat_total_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
                "unit": "g"
              },
              {
                "nutritionName": "fat_saturated_g",
                "amount": (double.tryParse(formController["fat_saturated_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
                "unit": "g"
              },
              {
                "nutritionName": "protein_g",
                "amount": (double.tryParse(formController["protein_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
                "unit": "g"
              },
              {
                "nutritionName": "sodium_mg",
                "amount": double.tryParse(formController["sodium_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "mg"
              },
              {
                "nutritionName": "potassium_mg",
                "amount": double.tryParse(formController["potassium_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "mg"
              },
              {
                "nutritionName": "cholesterol_mg",
                "amount": double.tryParse(formController["cholesterol_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "mg"
              },
              {
                "nutritionName": "carbohydrates_total_g",
                "amount": double.tryParse(formController["carbohydrates_total_g"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "g"
              },
              {
                "nutritionName": "fiber_g",
                "amount": double.tryParse(formController["fiber_g"]?.text.toString().trim() ?? "0") ?? 0 * cv,
                "unit": "g"
              },
              {"nutritionName": "sugar_g", "amount": double.tryParse(formController["sugar_g"]?.text.toString().trim() ?? "0") ?? 0 * cv, "unit": "g"}
            ]
          };
          Object obj = jsonEncode(item);
          if (await updateFood(obj, f)) {
            Get.back();
          }
        }
      }
    }
  }

  Future<void> logWater() async {
    if (formController["water"]!.text.isEmpty) {
      Get.defaultDialog(radius: 8, title: "Please add water", middleText: "Please add water.", textCancel: "OK", onCancel: () {});
      return;
    } else {
      String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(sltDate);
      var item;

      if (title == "Update Log Water") {
        item = {
          "logDiaryId": logDiaryDTO.logDiaryItemId,
          "dateLog": formattedDateTime,
          "water": double.parse(formController["water"]!.text),
          "logDiaryType": "Water"
        };
        Object obj = jsonEncode(item);
        NetworkApiService networkApiService = NetworkApiService();
        DiaryController clr = Get.find<DiaryController>();

        http.Response res = await networkApiService.postApi("/log-diary/update-diary/${clr.loginResponse.userId}", obj);
        logDiaryDTO.water = double.parse(formController["water"]!.text);

        if (res.statusCode == 200) {
          DiaryController diaryController = Get.find<DiaryController>();
          diaryController.water.removeAt(int.parse(indexV.value));
          diaryController.water.insert(int.parse(indexV.value), logDiaryDTO);
        }
      } else {
        item = {"logDiaryId": "", "dateLog": formattedDateTime, "water": double.parse(formController["water"]!.text), "logDiaryType": "Water"};
        Object obj = jsonEncode(item);
        NetworkApiService networkApiService = NetworkApiService();
        HomeController clr = Get.find<HomeController>();
        http.Response res = await networkApiService.postApi("/log-diary/add-log/${clr.loginResponse.userId}", obj);

        if (res.statusCode == 200) {
          LogDiaryDTO logDiaryDTO = LogDiaryDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
          DiaryController diaryController = Get.find<DiaryController>();
          diaryController.water.add(logDiaryDTO);
        }
      }

      Get.close(1);
    }
  }

  Future<void> quickLog() async {
    if (formController["calories"]!.text.isEmpty) {
      Get.defaultDialog(radius: 8, title: "Please add calories", middleText: "Please add calories.", textCancel: "OK", onCancel: () {});
      return;
    } else {
      String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(sltDate);
      var item;
      var cv=1;
      var itemFood = {
        "foodId": const Uuid().v4(),
        "foodName": "Quick Add",
        "description": "Quick Add",
        "numberOfServing":1.0,
        "servingSize": 100,
        "nutrition": [
          {"nutritionName": "calories", "amount": double.tryParse(formController["calories"]!.text.toString().trim())! * cv, "unit": "cal"},
          {"nutritionName": "serving_size_g", "amount": "100", "unit": "g"},
          {
            "nutritionName": "fat_total_g",
            "amount": (double.tryParse(formController["fat_total_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
            "unit": "g"
          },
          {
            "nutritionName": "fat_saturated_g",
            "amount": (double.tryParse(formController["fat_saturated_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
            "unit": "g"
          },
          {
            "nutritionName": "protein_g",
            "amount": (double.tryParse(formController["protein_g"]?.text.toString().trim() ?? "0") ?? 0) * cv,
            "unit": "g"
          },
          {
            "nutritionName": "sodium_mg",
            "amount": double.tryParse(formController["sodium_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
            "unit": "mg"
          },
          {
            "nutritionName": "potassium_mg",
            "amount": double.tryParse(formController["potassium_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
            "unit": "mg"
          },
          {
            "nutritionName": "cholesterol_mg",
            "amount": double.tryParse(formController["cholesterol_mg"]?.text.toString().trim() ?? "0") ?? 0 * cv,
            "unit": "mg"
          },
          {
            "nutritionName": "carbohydrates_total_g",
            "amount": double.tryParse(formController["carbohydrates_total_g"]?.text.toString().trim() ?? "0") ?? 0 * cv,
            "unit": "g"
          },
          {
            "nutritionName": "fiber_g",
            "amount": double.tryParse(formController["fiber_g"]?.text.toString().trim() ?? "0") ?? 0 * cv,
            "unit": "g"
          },
          {"nutritionName": "sugar_g", "amount": double.tryParse(formController["sugar_g"]?.text.toString().trim() ?? "0") ?? 0 * cv, "unit": "g"}
        ]
      };
      item = {
        "logDiaryId": "",
        "dateLog": formattedDateTime,
        "foodLogItem": {
          "food": itemFood,
          "numberOfServing": 1.0,
          "foodLogType": "food"
        },
        "logDiaryType": selectedMeal.value
      };
      Object obj = jsonEncode(item);
      NetworkApiService networkApiService = NetworkApiService();
      HomeController clr = Get.find<HomeController>();
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
