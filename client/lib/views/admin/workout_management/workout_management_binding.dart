import 'package:do_an_2/views/admin/workout_management/exercise/exercise_controller.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';

import 'package:get/get.dart';

import 'workout_management_controller.dart';

class WorkoutManagementBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WorkoutManagementController>(() => WorkoutManagementController());
  }
}
