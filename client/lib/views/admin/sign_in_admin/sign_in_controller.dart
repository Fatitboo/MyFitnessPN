import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../data/network/network_api_service.dart';
import '../../../data/response/custom_response.dart';
import '../../../model/login_response.dart';
import '../../../res/routes/names.dart';
import '../../../res/store/user.dart';

class SignInAdminController extends GetxController {
  final formField = GlobalKey<FormState>();
  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Future signAdminIn() async {
    try {
      handleSignIn(usernameController.text.toString().trim(),
          passwordController.text.toString().trim(), "0");
    } catch (e) {}
  }

  Future<void> handleSignIn(
      String username, String pass, String ggAccId) async {
    var information = {
      'username': username,
      'password': pass,
      'userType': "admin",
      "google_account_id": ggAccId
    };
    Object object = jsonEncode(information);
    print(object);
    http.Response postApi =
    await NetworkApiService().postApi("/users/login", object);

    CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(postApi.body));
    if (postApi.statusCode == 200) {
      UserStore.to.saveProfile(customResponse.user ??
          LoginResponse(
              userId: customResponse.user?.userId,
              fullName: customResponse.user?.fullName,
              email: customResponse.user?.email,
              token: customResponse.user?.token,
              userType: customResponse.user?.userType));
      UserStore.to.setToken(customResponse.user!.token ?? "");
      print("gg");
      Get.offAndToNamed(AppRoutes.APPLICATION_ADMIN);
    } else {
      print(customResponse.message);
    }
  }
}