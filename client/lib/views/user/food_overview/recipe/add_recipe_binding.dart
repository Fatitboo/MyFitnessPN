import 'package:do_an_2/views/user/food_overview/recipe/add_recipe_controller.dart';
import 'package:get/get.dart';

class AddRecipeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddRecipeController>(() => AddRecipeController());
  }

}