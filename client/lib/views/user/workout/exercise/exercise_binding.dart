import 'package:do_an_2/views/user/workout/exercise/exercise_controller.dart';
import 'package:get/get.dart';

class ExerciseBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ExerciseController>(() => ExerciseController());
  }

}