import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:get/get.dart';

class DiaryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DiaryController>(() => DiaryController());
  }
  
}