

import 'package:do_an_2/views/user/plan/plan_controller.dart';
import 'package:get/get.dart';

class PlanBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PlanController>(() => PlanController());
  }

}