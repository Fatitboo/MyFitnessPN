import 'dart:convert';

import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:get/get.dart';

import '../../../data/network/network_api_service.dart';
import '../../../model/userHealthDTO.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController{
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
  HomeController hctrl = Get.find<HomeController>();
  @override
  Future<void> onInit() async {
    super.onInit();

  }
  Future<void> getUserHealth() async {
    try {
      http.Response getApi = await NetworkApiService().getApi("/users/get_user_health/${hctrl.loginResponse.userId}");
      Map<String, dynamic> i = json.decode(utf8.decode(getApi.bodyBytes));
      userHealthDTO.value = UserHealthDTO.fromJson(i["userHealth"]);
    } catch (err) {
      print(err);
    }
  } 
}