import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:get/get.dart';

class PlanAdminBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PlanAdminController>(() => PlanAdminController());
  }
}
