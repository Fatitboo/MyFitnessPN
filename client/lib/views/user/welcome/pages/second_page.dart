import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';
import '../../../../res/values/constants.dart';
import '../../../../res/widgets/my_button.dart';
import '../components/SimpleButtonCard.dart';
import '../welcome_controller.dart';

class SecondPage extends GetView<WelcomeController> {
  final VoidCallback onTap;
  final VoidCallback back;
  var selectedIndex = 0.obs;

  SecondPage({super.key, required this.onTap, required this.back});

  void changeStatus(var index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "What is your gender?",
            style: TextStyle(color: AppColor.blackText, fontSize: 24, fontFamily: 'Gothic', fontWeight: FontWeight.w900),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SimpleButtonCard(
                  buttonText: "Male",
                  backgroundColor: controller.gender.value == Constant.male ? AppColor.primaryColor1 : Colors.white,
                  textColor: controller.gender.value == Constant.male ? Colors.white : Colors.black,
                  iconAssets: 'assets/images/male.jpg',
                  onTap: () {
                    changeStatus(0);
                    controller.gender.value = Constant.male;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SimpleButtonCard(
                  buttonText: "Female",
                  backgroundColor: controller.gender.value == Constant.female ? AppColor.primaryColor1 : Colors.white,
                  textColor: controller.gender.value == Constant.female ? Colors.white : Colors.black,
                  iconAssets: 'assets/images/female.jpg',
                  onTap: () {
                    changeStatus(1);
                    controller.gender.value = Constant.female;
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
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          back();
                        },
                        child: const Text('Back')),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MyButton(
                        onTap: () {
                          onTap();
                        },
                        height: 50,
                        bgColor: AppColor.blackText,
                        textString: 'Next',
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ));
    });
  }
}
