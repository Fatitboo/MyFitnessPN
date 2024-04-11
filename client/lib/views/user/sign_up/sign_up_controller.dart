import 'dart:convert';

import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../res/routes/names.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

class SignUpController extends GetxController {
  final formField = GlobalKey<FormState>();
  GoogleSignInAccount? _currentUser;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repassController = TextEditingController();
  toPageSignIn() async {
    Get.offAndToNamed(AppRoutes.SIGN_IN_USER);
  }

  Future<void> SignUpGG() async {
    var user = await _googleSignIn.signIn();
    print(user);
    handleSignUp(user!.id, "1", "1", user!.id, user.email, user.displayName??user!.id.substring(10));
  }

  void signUserUp() {
    handleSignUp(
        usernameController.text.toString().trim(),
        passwordController.text.toString().trim(),
        passwordController.text.toString().trim(),
        "0",emailController.text.toString().trim(),
        usernameController.text.toString().trim(),
    );
  }

  Future<void> handleSignUp (
      String username, String pass, String cpass, String ggAccId, String email, String fullName) async {
    var information = {
      'username': username,
      'password': pass,
      'cpassword': cpass,
      "fullName": fullName,
      "email": email,
      'height': 180,
      'weight': 90,
      'goalWeight': 100,
      'age': 28,
      'gender': 'male',
      'goal': 'bulking_slow',
      'exercise': 'heavy',
      "dayOfBirth": "1996-03-16T00:00:00",
      "google_account_id": ggAccId
    };
    Object object = jsonEncode(information);
    print(object);
    var postApi = NetworkApiService().postApi("/users/register", object);
    print(postApi);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
