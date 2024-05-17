import 'package:get/get.dart';

import 'add_discover_recipe_controller.dart';

class AddDiscoverRecipeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddDiscoverRecipeController>(() => AddDiscoverRecipeController());
  }

}