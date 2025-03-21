import 'package:do_an_2/views/user/food_overview/add_food/add_food_controller.dart';
import 'package:get/get.dart';

class AddFoodBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddFoodController>(() => AddFoodController());
  }

}