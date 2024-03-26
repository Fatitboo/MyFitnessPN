import 'package:do_an_2/res/widgets/my_button.dart';
import 'package:do_an_2/res/widgets/my_textfield.dart';
import 'package:do_an_2/res/widgets/round_button.dart';
import 'package:do_an_2/views/user/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
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
                    const SizedBox(height: 30),

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
                          fontWeight: FontWeight.normal
                      ),
                    ),
                    // welcome back, you've been missed!
                    Text(
                      'Create a new account!',
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
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),
                    MyTextField(
                      controller: controller.repassController,
                      hintText: 'Enter Password again' ,
                      obscureText: true,
                    ),



                    const SizedBox(height: 25),

                    // sign in button
                    RoundButton(
                        title: "Sign Up",
                        onPressed: () {
                          controller.signUserUp();
                        }),

                    const SizedBox(height: 50),


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
                    )
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
