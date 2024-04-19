import 'package:get/get.dart';

import 'meal_management_controller.dart';

class MealManagementBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MealManagementController>(() => MealManagementController());
  }

}
