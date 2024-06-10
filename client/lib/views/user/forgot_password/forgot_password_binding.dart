import 'package:do_an_2/views/user/forgot_password/forgot_password_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }

}