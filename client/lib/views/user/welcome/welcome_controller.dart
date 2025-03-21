import 'dart:convert';

import 'package:do_an_2/model/userHealthDTO.dart';
import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:do_an_2/views/user/profile/profile_controller.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/network/network_api_service.dart';

class WelcomeController extends GetxController {
  var progressValue = 0.0.obs;
  var index = 0.obs;
  //Goal
  var goal = Constant.GOAL_maintenance.obs;
  var exerciseLevel = Constant.EXC_ACTIVE_little.obs;
  var gender = Constant.male.obs;
  var height = 170.obs;
  var weight = 60.obs;
  var goalWeight = 60.obs;
  var rulerTallPickerController = RulerPickerController(value: 170).obs;
  var rulerWeightPickerController = RulerPickerController(value: 60).obs;

  var rulerPickerController = RulerPickerController(value: 60).obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  List<RulerRange> ranges = [RulerRange(begin: 70, end: 200, scale: 1)];
  var indexV = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    indexV.value = Get.parameters["type"] ?? "";
    if (Get.isRegistered<ProfileController>()) {
      ProfileController profileController = Get.find<ProfileController>();

      UserHealthDTO u = profileController.userHealthDTO.value;
      selectedDate.value = profileController.hctrl.loginResponse.dob!;
      goal.value = u.goal!;
      exerciseLevel.value = u.exercise!;
      gender.value = u.gender!;
      height.value = u.height!.toInt();
      rulerTallPickerController.value = RulerPickerController(value: height.value.toInt());
      weight.value = u.weight!.toInt();
      rulerWeightPickerController.value = RulerPickerController(value: weight.value.toInt());
      goalWeight.value = u.goalWeight!.toInt();
      rulerPickerController.value = RulerPickerController(value: goalWeight.value.toInt());
    }
  }

  setRulerValue() {
    if(indexV.value != "EditProfile"){
      goalWeight.value = weight.value;
    }
    rulerPickerController.value = RulerPickerController(value: weight.value);
    if (goal.value == Constant.GOAL_loseWeight) {
      ranges = [RulerRange(begin: 40, end: weight.value, scale: 1)];
    } else if (goal.value == Constant.GOAL_gainWeight) {
      ranges = [RulerRange(begin: weight.value, end: 200, scale: 1)];
    } else {
      ranges = [RulerRange(begin: weight.value - 8, end: weight.value + 8, scale: 1)];
    }
  }

  toPageApplication() async {
    Get.toNamed(AppRoutes.SIGN_UP);
  }

  toPageSignUp() async {
    Get.offAndToNamed(AppRoutes.SIGN_UP);
  }

  void changePage(int index) {
    this.index.value = index;

    setRulerValue();

    progressValue.value = index / 6;
  }
  Future<void> handleUpdate() async {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - selectedDate.value.year;
    var information = {
      'username': Get.find<HomeController>().loginResponse.fullName,
      'password': "",
      'cpassword': "cpass",
      "fullName": "fullName",
      "email": "email",
      'height':  height.value,
      'weight':  weight.value,
      'goalWeight':  goalWeight.value,
      'age': age,
      'gender':  gender.value,
      'goal':  goal.value,
      'exercise':  exerciseLevel.value,
      "dayOfBirth":  selectedDate.value.toIso8601String(),
      "google_account_id": "ggAccId"
    };
    Object object = jsonEncode(information);
    print(object);
    http.Response postApi = await NetworkApiService().postApi("/users/update", object) ;
    print("huh");

    if (postApi.statusCode == 200) {
      Get.back();
    }
  }
}
