import 'package:do_an_2/views/user/food_overview/pick_image/pick_image_controller.dart';
import 'package:get/get.dart';

class PickImageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PickImageController>(() => PickImageController());
  }
  
}