import 'dart:convert';

import 'package:do_an_2/data/response/custom_response.dart';
import 'package:do_an_2/models/login_response.dart';
import 'package:do_an_2/res/store/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/network/network_api_service.dart';
import '../../../res/routes/names.dart';
import 'package:http/http.dart' as http;

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

class SignInController extends GetxController {
  final formField = GlobalKey<FormState>();

  GoogleSignInAccount? _currentUser;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future signUserInGG() async {
    try {
      var user = await _googleSignIn.signIn();
      print(user);
      handleSignIn(user!.id, "1", user!.id);
    } catch (e) {
      print(e);
      print(e.toString());
      Get.snackbar(
        "Error",
        e.toString(),
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future signUserIn() async {
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
      'userType': "user",
      "google_account_id": ggAccId
    };
    Object object = jsonEncode(information);
    print(object);
    http.Response postApi =
        await NetworkApiService().postApi("/users/login", object);


    CustomResponse customResponse =
        CustomResponse.fromJson(jsonDecode(postApi.body));
    if (postApi.statusCode == 200) {
      UserStore.to.saveProfile(customResponse.user ??
          LoginResponse(
              userId: customResponse.user?.userId,
              fullName: customResponse.user?.fullName,
              email: customResponse.user?.email,
              token: customResponse.user?.token,
              userType: customResponse.user?.userType));
      UserStore.to.setToken(customResponse.user!.token ?? "");
      Get.offAndToNamed(AppRoutes.APPLICATION_USER);
    } else {
      print(customResponse.message);
    }
  }

  toPageSignUp() async {
    Get.offAndToNamed(AppRoutes.SIGN_UP);
    // _googleSignIn.disconnect();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
