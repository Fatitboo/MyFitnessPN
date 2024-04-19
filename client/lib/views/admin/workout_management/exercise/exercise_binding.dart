
import 'package:do_an_2/views/admin/workout_management/exercise/exercise_controller.dart';
import 'package:get/get.dart';


class ExerciseAdminBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ExerciseController>(() => ExerciseController());
  }
}
