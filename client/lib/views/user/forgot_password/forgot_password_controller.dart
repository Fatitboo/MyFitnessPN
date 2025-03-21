import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/network/network_api_service.dart';
import '../../../res/routes/names.dart';

class ForgotPasswordController extends GetxController {
  final formField = GlobalKey<FormState>();
  final formField1 = GlobalKey<FormState>();
  final formField2 = GlobalKey<FormState>();
  var username = "";
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  Future<void> sendRequestReset() async {
    try {
      http.Response postApi = await NetworkApiService().getApi("/users/check-username?username=${emailController.text.trim()}");
      if (postApi.statusCode == 200) {
        Get.toNamed(AppRoutes.ENTER_OTP);
        username = emailController.text.trim();
      } else {
        Get.snackbar(
          "Bad Request",
          jsonDecode(postApi.body).message,
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on Exception catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> checkOtp() async {
    try {
      print('$username');
      http.Response postApi = await NetworkApiService().getApi("/users/$username/check-otp?otp=${otpController.text.trim()}");
      if (postApi.statusCode == 200) {
        Get.toNamed(AppRoutes.RESET_PASS);
      } else {
        Get.snackbar(
          "Bad Request",
          jsonDecode(postApi.body).message,
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on Exception catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> resetPassword() async {
    try {
      var information = {
        'username': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };
      Object object = jsonEncode(information);
      print(object);
      http.Response postApi = await NetworkApiService().postApi("/user/reset-password", object);
      if (postApi.statusCode == 200) {
        Get.defaultDialog(
            radius: 8,
            title: "Reset password successfully!",
            middleText: "Please login to use app.",
            textConfirm: "OK",
            onConfirm: () {
              Get.offAndToNamed(AppRoutes.SIGN_IN_USER);
            });
      } else {
        Get.snackbar(
          "Bad Request",
          jsonDecode(postApi.body).message,
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on Exception catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
