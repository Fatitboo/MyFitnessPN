import 'dart:convert';

import 'package:do_an_2/model/logDiaryDTO.dart';
import 'package:do_an_2/model/login_response.dart';
import 'package:do_an_2/res/store/store.dart';
import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../data/network/network_api_service.dart';

class DiaryController extends GetxController {
  var dateStr = "".obs;
  late DateTime today;
  RxList breakfast = [].obs;
  RxList lunch = [].obs;
  RxList dinner = [].obs;
  RxList water = [].obs;
  RxList exercise = [].obs;
  RxList snack = [].obs;
  Future<void> getLogDiaryByDateFoodSaved(DateTime d) async {
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(d);
    try {
      LoginResponse loginResponse = LoginResponse.fromJson(
          jsonDecode(StorageService.to.getString(STORAGE_USER_PROFILE_KEY)));
      http.Response getApi = await NetworkApiService()
          .getApi("/log-diary/${loginResponse.userId}/$formattedDateTime");
      Iterable i = json.decode(utf8.decode(getApi.bodyBytes));
      List<LogDiaryDTO> diaries =
          List<LogDiaryDTO>.from(i.map((model) => LogDiaryDTO.fromJson(model)))
              .toList();
      breakfast.clear();
      lunch.clear();
      dinner.clear();
      snack.clear();
      water.clear();
      exercise.clear();
      for (LogDiaryDTO l in diaries) {
        if (l.logDiaryType == "Breakfast") breakfast.add(l);
        if (l.logDiaryType == "Lunch") lunch.add(l);
        if (l.logDiaryType == "Dinner") dinner.add(l);
        if (l.logDiaryType == "Snack") snack.add(l);
        if (l.logDiaryType == "Water") water.add(l);
        if (l.logDiaryType == "Exercise") exercise.add(l);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  void onInit()async {
    super.onInit();
    today = DateTime.now();
    // HomeController homeController = Get.find<HomeController>();
    String formattedDate = DateFormat('MMM d').format(today).toUpperCase();
    dateStr.value = formattedDate;

    await getLogDiaryByDateFoodSaved(today);
  }

  double getTotalCalories(RxList l) {
    double tt = 0.0;
    for (var item in l) {
      if (item.logDiaryType == "Exercise") {
      } else if (item.logDiaryType == "Water") {
        tt += item.water;
      } else {
        var logFood = item.foodLogItem!;
        tt += logFood.getCaloriesPerItem() ?? 0.0;
      }
    }
    return tt;
  }
  double getTotalWater(){
    double tt = 0.0;
    if (water.isEmpty) return 0.1;
    for (var item in water) {
      if (item.logDiaryType == "Exercise") {
      } else if (item.logDiaryType == "Water") {
        tt += item.water;
      } else {
        var logFood = item.foodLogItem!;
        tt += logFood.getCaloriesPerItem() ?? 0.0;
      }
    }
    return tt;
  }
  double getTotalCaloriesOfFood() {
    return getTotalCalories(breakfast) +
        getTotalCalories(lunch) +
        getTotalCalories(dinner) +
        getTotalCalories(snack);
  }

  void onDateChange(DateTime d) {
    print(d);
    String formattedDate = DateFormat('MMM d').format(d).toUpperCase();
    getLogDiaryByDateFoodSaved(d);
    dateStr.value = formattedDate;
  }

  double getCaloriesNeed(){
    HomeController homeController = Get.find<HomeController>();

    return homeController.userHealthDTO.value?.getCaloriesNeed() ?? 0;
  }
}
