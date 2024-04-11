import 'package:do_an_2/res/widgets/my_button.dart';
import 'package:do_an_2/res/widgets/my_textfield.dart';
import 'package:do_an_2/res/widgets/round_button.dart';
import 'package:do_an_2/views/user/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<SignUpController> {
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
                    Text(
                      'Hi there!',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    // welcome back, you've been missed!
                    Text(
                      'Create a new account!',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                     Form(
                          key: controller.formField,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              // username textfield
                              MyTextField(
                                controller: controller.usernameController,
                                hintText: 'Username',

                              ),
                              const SizedBox(height: 10),

                              MyTextField(
                                controller: controller.emailController,
                                hintText: 'Email',
                                checkEmail: true,
                              ),
                              const SizedBox(height: 10),

                              // password textfield
                              MyTextField(
                                controller: controller.passwordController,
                                hintText: 'Password',
                                isPass: true,
                              ),

                              const SizedBox(height: 10),
                              MyTextField(
                                controller: controller.repassController,
                                hintText: 'Enter Password again',
                                isPass: true,
                              ),
                            ],
                          ),
                        ),
                    const SizedBox(height: 20),
                    // sign in button
                    RoundButton(
                        title: "Sign Up",
                        onPressed: () {
                          if (controller.formField.currentState!.validate()) {
                            controller.signUserUp();

                          }
                        }),

                    const SizedBox(height: 30),

                    // Already have an account? Sign In
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            controller.toPageSignIn();
                          },
                        ),
                      ],
                    ),
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
                            onPressed: () => controller.SignUpGG(),
                            icon: Image.asset("assets/icons/google.png"),
                            label: const Text(
                              'Sign up with Google',
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
