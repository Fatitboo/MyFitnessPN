import 'package:get/get.dart';

import 'food_overview_controller.dart';

class FoodOverviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FoodOverviewController>(() => FoodOverviewController());
  }

}