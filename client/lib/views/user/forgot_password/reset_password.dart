import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/values/color_extension.dart';
import '../../../res/widgets/my_textfield.dart';
import '../../../res/widgets/round_button.dart';
import 'forgot_password_controller.dart';

class ResetPasswordPage extends GetView<ForgotPasswordController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/bg_login.png'), fit: BoxFit.cover)),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  print("back");
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Reset your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: AppColor.primaryColor1),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 6),
                      child: Text(
                        'Reset your password to login again!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Form(
                      // key: controller.formField2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextField(hintText: 'Password', controller: controller.passwordController,  isPass: true),
                            const SizedBox(height: 20,),
                            MyTextField(hintText: 'Confirm password', controller: controller.confirmPassController, isPass: true),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: RoundButton(
                          title: "Send",
                          onPressed: () {
                            if (controller.formField2.currentState!.validate()) {
                              controller.resetPassword();
                            }
                          },
                        )),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 30, horizontal: 30),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Get.offAndToNamed(AppRoutes.SIGN_IN);
                    //     },
                    // child: const Text(
                    //   'Already have an account',
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.black),
                    // ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}