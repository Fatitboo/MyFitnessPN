import 'package:get/get.dart';

import 'workout_management_controller.dart';

class WorkoutManagementBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WorkoutManagementController>(() => WorkoutManagementController());
  }

}
