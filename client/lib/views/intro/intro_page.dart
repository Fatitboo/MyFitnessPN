import 'package:do_an_2/res/widgets/my_button.dart';
import 'package:do_an_2/views/intro/intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/widgets/round_button.dart';

class IntroPage extends GetView<IntroController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            children: [
              // big logdo
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 70.0,
              //     right: 70.0,
              //     top: 40,
              //     bottom: 20,
              //   ),
              //   child: Image.asset('assets/images/avocado.png'),
              // ),

              // MyfitnessPN the new way of healthy
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'MyfitnessPN',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'A new way of healthy',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Quickly and easily track your diet progress every day
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 58.0),
                child: Text(
                  'Quickly and easily track your diet progress every day',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),

              const SizedBox(height: 45),

              // ready to start

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButton(
                    title: "Ready to start",
                    onPressed: () {
                      controller.getReadyStart();
                    }),
              ),
              // get started button
              const SizedBox(height: 15),

              // sign in admin role
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  onTap: () {
                    controller.loginAdminRole();
                  },
                  bgColor: Colors.greenAccent.shade100,
                  textString: 'Login Admin role',
                  textColor: Colors.black,
                  elevation: 0.1,
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
