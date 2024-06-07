import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:get/get.dart';

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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  setRulerValue() {
    goalWeight.value = weight.value;
    rulerPickerController.value = RulerPickerController(value: weight.value);
    if (goal.value == Constant.GOAL_loseWeight) {
      ranges = [RulerRange(begin: 40, end: weight.value, scale: 1)];
    } else if (goal.value == Constant.GOAL_gainWeight) {
      ranges = [RulerRange(begin: weight.value, end: 200, scale: 1)];
    } else {
      ranges = [
        RulerRange(begin: weight.value - 8, end: weight.value + 8, scale: 1)
      ];
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
}
