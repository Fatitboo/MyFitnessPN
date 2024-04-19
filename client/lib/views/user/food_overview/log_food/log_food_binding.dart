import 'package:do_an_2/views/user/food_overview/log_food/log_food_controller.dart';
import 'package:get/get.dart';

class LogFoodBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LogFoodController>(() => LogFoodController());
  }

}