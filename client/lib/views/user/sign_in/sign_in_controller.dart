import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/routes/names.dart';

class SignInController extends GetxController {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn() {
    // Get.offAndToNamed(AppRoutes.WELCOME);
  }
  toPageSignUp() async {
    Get.offAndToNamed(AppRoutes.SIGN_UP);
  }
}