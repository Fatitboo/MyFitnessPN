import 'package:do_an_2/views/user/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignInController>(() => SignInController());
  }
}