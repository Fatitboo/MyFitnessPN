import 'package:do_an_2/views/user/application_user/application_controller.dart';
import 'package:get/get.dart';

class ApplicationUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationUserController>(() => ApplicationUserController());
  }
  
}