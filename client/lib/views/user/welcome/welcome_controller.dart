import 'package:do_an_2/res/routes/names.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {



  var progressValue = 0.0.obs;
  var index = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  toPageApplication() async {
    Get.offAndToNamed(AppRoutes.APPLICATION_USER);
  }
  toPageSignUp() async {
    Get.offAndToNamed(AppRoutes.SIGN_UP);
  }
  void changePage(int index){
    this.index.value = index;
    progressValue.value = index/3;
  }
}