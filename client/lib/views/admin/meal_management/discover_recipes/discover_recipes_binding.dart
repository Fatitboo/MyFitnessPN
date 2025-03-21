import 'package:do_an_2/views/admin/meal_management/discover_recipes/discover_recipes_controller.dart';
import 'package:get/get.dart';

class DiscoverRecipesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DiscoverRecipesController>(() => DiscoverRecipesController());
  }

}