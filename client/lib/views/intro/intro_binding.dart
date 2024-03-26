import 'package:do_an_2/views/intro/intro_controller.dart';
import 'package:get/get.dart';

class IntroBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<IntroController>(() => IntroController());
  }

}