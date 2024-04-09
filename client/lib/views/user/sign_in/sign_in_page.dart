import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/res/widgets/my_button.dart';
import 'package:do_an_2/res/widgets/my_textfield.dart';
import 'package:do_an_2/res/widgets/round_button.dart';
import 'package:do_an_2/views/user/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
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
                      const SizedBox(height: 20),

                      // logo
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 70.0,
                          right: 70.0,
                          top: 00,
                          bottom: 0,
                        ),
                        child: Image.asset('assets/images/food.png'),
                      ),

                      // welcome back, you've been missed!
                      Text(
                        'Welcome back you\'ve been missed!',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: 320,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 25),
                              // username textfield
                              MyTextField(
                                controller: controller.usernameController,
                                hintText: 'Email',
                                checkEmail: true,
                              ),
                          
                              const SizedBox(height: 20),
                          
                              // password textfield
                              MyTextField(
                                controller: controller.passwordController,
                                hintText: 'Password',
                                isPass: true,
                                checkLength: 6,
                              ),
                          
                              const SizedBox(height: 10),
                              // forgot password?
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),

                              // sign in button
                              RoundButton(
                                  title: "Sign In",
                                  onPressed: () {
                                    Get.offAndToNamed(AppRoutes.APPLICATION_USER);

                                    // if (controller.formField.currentState!.validate()) {
                                    // }
                                  }),

                            ],
                          ),
                        ),
                      ),


                      const SizedBox(height: 40),

                      // or continue with
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // google sign in buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: 40.h,
                          width: double.infinity,
                          child: OutlinedButton.icon(
                              onPressed: () => controller.signUserIn(),
                              icon: Image.asset("assets/icons/google.png"),
                              label: const Text(
                                'Sign In with Google',
                                style: TextStyle(color: Color(0xff2186ab)),
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.purple),
                                borderRadius: BorderRadius.circular(10.0),
                              )))),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // not a member? register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            child: const Text(
                              'Register now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              controller.toPageSignUp();
                            },
                          ),
                        ],
                      )
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
