import 'package:do_an_2/views/admin/plan_management/plan_management_controller.dart';
import 'package:get/get.dart';

class PlanManagementBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PlanManagementController>(() => PlanManagementController());
  }

}
