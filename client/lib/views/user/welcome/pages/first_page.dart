import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:do_an_2/res/widgets/my_button.dart';
import 'package:do_an_2/views/user/welcome/components/SimpleButtonCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../welcome_controller.dart';

class FirstPage extends GetView<WelcomeController> {
  final VoidCallback onTap;
  var selectedIndex = 3.obs;
  
  FirstPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  void changeStatus(var index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("What's your goal?", style: TextStyle(
                            color: AppColor.blackText,
                            fontSize: 24,
                            fontFamily: 'Gothic',
                            fontWeight: FontWeight.w900),),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SimpleButtonCard(
                      buttonText: "Stay Healthy",
                      backgroundColor: selectedIndex.value == 0 ? AppColor.primaryColor1 : Colors.white,
                      textColor: selectedIndex.value == 0 ? Colors.white : Colors.black,
                      iconAssets: 'assets/icons/stayhealthy.png',
                      onTap: () {
                        changeStatus(0);
                        controller.goal.value = Constant.GOAL_maintenance;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SimpleButtonCard(
                      buttonText: "Loss weight",
                      backgroundColor: selectedIndex.value == 1 ? AppColor.primaryColor1 : Colors.white,
                      textColor: selectedIndex.value == 1 ? Colors.white : Colors.black,
                      iconAssets: 'assets/icons/loseweight.png',
                      onTap: () {
                        changeStatus(1);
                        controller.goal.value = Constant.GOAL_loseWeight;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SimpleButtonCard(
                      buttonText: 'Gain weight',
                      backgroundColor: selectedIndex.value == 2 ? AppColor.primaryColor1 : Colors.white,
                      textColor: selectedIndex.value == 2 ? Colors.white : Colors.black,
                      iconAssets: 'assets/icons/gainweight.png',
                      onTap: () {
                        changeStatus(2);
                        controller.goal.value = Constant.GOAL_gainWeight;
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                        child: MyButton(
                            onTap: () {
                              onTap();
                            },
                            bgColor: AppColor.blackText,
                            textString: 'Next',
                            textColor: Colors.white,
                        ),
                      ),
                    ],
                  )
              ),

            ],
          ),
              
        ),
    ));
  }
}
