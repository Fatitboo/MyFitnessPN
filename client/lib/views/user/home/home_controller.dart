import 'dart:convert';

import 'package:do_an_2/model/userHealthDTO.dart';
import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:do_an_2/views/user/profile/profile_controller.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:get/get.dart';

import '../../../data/network/network_api_service.dart';
import '../../../model/login_response.dart';
import '../../../res/store/storage.dart';
import '../../../res/store/user.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var token = " ".obs;
  var percent = 10.0.obs;
  var perWater = 0.0.obs;
  Rx<UserHealthDTO> userHealthDTO = UserHealthDTO(
      userHealthId: "userHealthId",
      userId: "userId",
      height: 0,
      weight: 0,
      age: 0,
      gender: "gender",
      exercise: "exercise",
      goalWeight: 0,
      goal: "goal",
      waterIntake: 0.1,
      bodyMassIndex: BodyMassIndex(value: 0, conclusion: "conclusion", unit: ""),
      bodyFatPercentage: BodyFatPercentage(bmi: Bmi(formulaName: "formulaName", value: 0, unit: [])),
      leanBodyMass: BodyFatPercentage(bmi: Bmi(formulaName: "formulaName", value: 0, unit: [])),
      restingDailyEnergyExpenditure: RestingDailyEnergyExpenditure(
          bmi: Hb(formulaName: "formulaName", calories: Calories(value: 0, unit: []), joules: Calories(value: 0, unit: []))),
      basalMetabolicRate: BasalMetabolicRate(
          hb: Hb(formulaName: "formulaName", calories: Calories(value: 0, unit: []), joules: Calories(value: 0, unit: [])),
          rs: Hb(formulaName: "formulaName", calories: Calories(value: 0, unit: []), joules: Calories(value: 0, unit: [])),
          msj: Hb(formulaName: "formulaName", calories: Calories(value: 0, unit: []), joules: Calories(value: 0, unit: []))),
      totalDailyEnergyExpenditure: BasalMetabolicRate(
          hb: Hb(formulaName: "formulaName", calories: Calories(value: 0, unit: []), joules: Calories(value: 0, unit: [])),
          rs: Hb(formulaName: "formulaName", calories: Calories(value: 0, unit: []), joules: Calories(value: 0, unit: [])),
          msj: Hb(formulaName: "formulaName", calories: Calories(value: 0, unit: []), joules: Calories(value: 0, unit: []))),
      idealBodyWeight: IdealBodyWeight(
          peterson: Devine(formulaName: "formulaName", metric: Calories(value: 0, unit: []), imperial: Calories(value: 0, unit: [])),
          lorentz: Devine(formulaName: "formulaName", metric: Calories(value: 0, unit: []), imperial: Calories(value: 0, unit: [])),
          hamwi: Devine(formulaName: "formulaName", metric: Calories(value: 0, unit: []), imperial: Calories(value: 0, unit: [])),
          devine: Devine(formulaName: "formulaName", metric: Calories(value: 0, unit: []), imperial: Calories(value: 0, unit: [])),
          robinson: Devine(formulaName: "formulaName", metric: Calories(value: 0, unit: []), imperial: Calories(value: 0, unit: [])),
          miller: Devine(formulaName: "formulaName", metric: Calories(value: 0, unit: []), imperial: Calories(value: 0, unit: [])))).obs;
  LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(StorageService.to.getString(STORAGE_USER_PROFILE_KEY)));
  var rulerWeightPickerController = RulerPickerController(value: 60).obs;
  var currentWeight = (80.0).obs;
  @override
  void onInit() async {
    await getUserHealth();
    // percent.value = getLogInfor()["food"]! * 100 / userHealthDTO.value.getCaloriesNeed();
    percent.value = 60.0;
    super.onInit();
  }

  Future<void> getUserHealth() async {
    try {
      http.Response getApi = await NetworkApiService().getApi("/users/get_user_health/${loginResponse.userId}");
      Map<String, dynamic> i = json.decode(utf8.decode(getApi.bodyBytes));
      userHealthDTO.value = UserHealthDTO.fromJson(i["userHealth"]);
      currentWeight.value = userHealthDTO.value.weight ?? 80.0;
      rulerWeightPickerController.value = RulerPickerController(value: (userHealthDTO.value.weight ?? 70).toInt() );
      perWater.value = ((getLogInfor()["water"]) ?? 0) / (userHealthDTO.value.waterIntake ?? 1000);
    } catch (err) {
      print(err);
    }
  }

  Map<String, double> getLogInfor() {
    DiaryController diaryController = Get.find<DiaryController>();

    return {"food": diaryController.getTotalCaloriesOfFood(), "exercise": 0, "water": diaryController.getTotalWater()};
  }
  Future<void> handleUpdate() async {
    DateTime currentDate = DateTime.now();
    var information = {
      'username': loginResponse.fullName,
      'password': "",
      'cpassword': "cpass",
      "fullName": "fullName",
      "email": "email",
      'height':  userHealthDTO.value.height,
      'weight':  currentWeight.value,
      'goalWeight': userHealthDTO.value. goalWeight,
      'age': userHealthDTO.value.age,
      'gender':  userHealthDTO.value.gender,
      'goal':  userHealthDTO.value.goal,
      'exercise':  userHealthDTO.value.exercise,
      "dayOfBirth": loginResponse.dob?.toIso8601String(),
      "google_account_id": "ggAccId"
    };
    Object object = jsonEncode(information);
    print(object);
    http.Response postApi = await NetworkApiService().postApi("/users/update", object) ;
    print("huh");

    if (postApi.statusCode == 200) {
      getUserHealth();
      Get.find<ProfileController>().getUserHealth();
    }
  }
}
