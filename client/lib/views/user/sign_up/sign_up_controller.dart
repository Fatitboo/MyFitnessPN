import 'dart:convert';

import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/routes/names.dart';

class SignUpController extends GetxController {
  final formField = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repassController = TextEditingController();
  toPageSignIn() async {
    Get.offAndToNamed(AppRoutes.SIGN_IN_USER);
  }

  void signUserUp(){
    var information = {
      'username': 'user3',
      'password': '1',
      'cPassword': '1',
      "fullName":"Tuan Vinh",
      "email":"21522448@gm.uit.edu.com",
      'height': 180,
      'weight': 90,
      'goalWeight': 100,
      'age': 28,
      'gender': 'male',
      'goal': 'bulking_slow',
      'exercise': 'heavy',
      "dayOfBirth":"1996-03-16T00:00:00",
      "google_account_id":"0"
    };
    Object object = jsonEncode(information);
    var postApi = NetworkApiService().postApi("/register", object);
    
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}