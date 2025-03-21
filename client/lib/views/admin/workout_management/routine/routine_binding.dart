import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:get/get.dart';

class RoutineAdminBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RoutineController>(() => RoutineController());
  }
}
