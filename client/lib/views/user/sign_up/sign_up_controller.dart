import 'dart:convert';

import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:do_an_2/views/user/welcome/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../data/response/custom_response.dart';
import '../../../model/login_response.dart';
import '../../../res/routes/names.dart';
import '../../../res/store/user.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

class SignUpController extends GetxController {
  final formField = GlobalKey<FormState>();
  GoogleSignInAccount? _currentUser;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  toPageSignIn() async {
    Get.offAndToNamed(AppRoutes.SIGN_IN_USER);
  }

  Future<void> SignUpGG() async {
    var user = await _googleSignIn.signIn();
    print(user);
    handleSignUp(user!.id, "1", "1", user!.id, user.email,
        user.displayName ?? user!.id.substring(10));
  }

  void signUserUp() {
    handleSignUp(
      usernameController.text.toString().trim(),
      passwordController.text.toString().trim(),
      passwordController.text.toString().trim(),
      "0",
      emailController.text.toString().trim(),
      fullNameController.text.toString().trim(),
    );
  }

  Future<void> handleSignUp(String username, String pass, String cpass,
      String ggAccId, String email, String fullName) async {
    WelcomeController w = Get.find<WelcomeController>();
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - w.selectedDate.value.year;

    var information = {
      'username': username,
      'password': pass,
      'cpassword': cpass,
      "fullName": fullName,
      "email": email,
      'height': w.height.value,
      'weight': w.weight.value,
      'goalWeight': w.goalWeight.value,
      'age': age,
      'gender': w.gender.value,
      'goal': w.goal.value,
      'exercise': w.exerciseLevel.value,
      "dayOfBirth": w.selectedDate.value.toIso8601String(),
      "google_account_id": ggAccId
    };
    Object object = jsonEncode(information);
    print(object);
    http.Response postApi = await NetworkApiService().postApi("/users/register", object) ;
    print("huh");
    CustomResponse customResponse = CustomResponse.fromJson(jsonDecode(postApi.body));

    if (postApi.statusCode == 200) {
      UserStore.to.saveProfile(customResponse.user ??
          LoginResponse(
              userId: customResponse.user?.userId,
              fullName: customResponse.user?.fullName,
              email: customResponse.user?.email,
              token: customResponse.user?.token,
              userType: customResponse.user?.userType,
              dob: customResponse.user?.dob));
      UserStore.to.setToken(customResponse.user!.token ?? "");
      Get.offAndToNamed(AppRoutes.APPLICATION_USER);
    }else {
      print(customResponse.message);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
