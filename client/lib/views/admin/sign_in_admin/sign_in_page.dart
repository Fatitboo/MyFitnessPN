import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/res/widgets/my_button.dart';
import 'package:do_an_2/res/widgets/my_textfield.dart';
import 'package:do_an_2/res/widgets/round_button.dart';
import 'package:do_an_2/views/admin/sign_in_admin/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInAdminPage extends GetView<SignInAdminController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Form(
                  key: controller.formField,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),

                      // logo
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 30.0,
                          top: 00,
                          bottom: 0,
                        ),
                        child: Image.asset('assets/images/admin.png'),
                      ),


                      // welcome back, you've been missed!
                      Text(
                        'Login to Admin role!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      const SizedBox(height: 25),

                      // username textfield
                      MyTextField(
                        controller: controller.usernameController,
                        hintText: 'Email',
                        icon: 'none',
                        checkEmail: true,
                      ),

                      const SizedBox(height: 10),

                      // password textfield
                      MyTextField(
                        controller: controller.passwordController,
                        hintText: 'Password',
                        icon: 'none',
                        isPass: true,

                      ),

                      const SizedBox(height: 10),

                      // forgot password?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // sign in button
                      RoundButton(
                          title: "Sign In",
                          onPressed: () {
                            controller.signAdminIn();
                            // if(controller.formField.currentState!
                            //     .validate()){
                            //
                            // }
                            // Get.offAndToNamed(AppRoutes.APPLICATION_ADMIN);
                          }),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
