import 'package:do_an_2/views/admin/sign_in_admin/sign_in_controller.dart';
import 'package:get/get.dart';

class SignInAdminBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignInAdminController>(() => SignInAdminController());
  }
}