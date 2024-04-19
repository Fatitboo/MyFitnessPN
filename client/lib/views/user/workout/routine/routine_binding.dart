import 'package:do_an_2/views/user/workout/routine/routine_controller.dart';
import 'package:get/get.dart';

class RoutineBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RoutineController>(() => RoutineController());
  }
}