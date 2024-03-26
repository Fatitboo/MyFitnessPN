import 'package:do_an_2/res/routes/names.dart';
import 'package:get/get.dart';

class IntroController extends GetxController{
  void getReadyStart(){
    Get.offAndToNamed(AppRoutes.SIGN_IN_USER);
  }
  void loginAdminRole(){
    Get.offAndToNamed(AppRoutes.SIGN_IN_ADMIN);
  }
}