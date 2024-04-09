import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../res/routes/names.dart';
final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      "email"
    ]
);
class SignInController extends GetxController {
  final formField = GlobalKey<FormState>();

  GoogleSignInAccount? _currentUser ;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Future signUserIn() async{
    try {
      var user = await _googleSignIn.signIn();
      print(user);
    }
    catch(e){
      print(e);
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