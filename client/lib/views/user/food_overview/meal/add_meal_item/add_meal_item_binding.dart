import 'package:do_an_2/views/user/food_overview/meal/add_meal_item/add_meal_item_controller.dart';
import 'package:get/get.dart';


class AddMealItemBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddMealItemController>(() => AddMealItemController());
  }

}