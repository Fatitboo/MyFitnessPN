import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/routes/names.dart';

class SignUpController extends GetxController {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repassController = TextEditingController();
  toPageSignIn() async {
    Get.offAndToNamed(AppRoutes.SIGN_IN_ADMIN);
  }
  void signUserUp(){}
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}