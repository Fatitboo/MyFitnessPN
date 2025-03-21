import 'package:do_an_2/views/admin/plan_management/plan/manage_task/manage_task_controller.dart';
import 'package:get/get.dart';

class ManageTaskBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ManageTaskController>(() => ManageTaskController());
  }
}