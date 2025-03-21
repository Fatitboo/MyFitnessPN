import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';
import '../../../../res/values/constants.dart';
import '../../../../res/widgets/my_button.dart';
import '../components/SimpleButtonCard.dart';
import '../welcome_controller.dart';

class FinalPage extends GetView<WelcomeController> {
  final VoidCallback back;
  final VoidCallback onTap;
  FinalPage({super.key, required this.back, required this.onTap});
  var selectedIndex = 0.obs;

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
            "How active are you?",
            style: TextStyle(color: AppColor.blackText, fontSize: 24, fontFamily: 'Gothic', fontWeight: FontWeight.w900),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SimpleButtonCard(
                  buttonText: "Not very active",
                  extraText: "I have a sedentary lifestyle. E.g. desk job, bank teller",
                  backgroundColor: controller.exerciseLevel.value == Constant.EXC_ACTIVE_little ? AppColor.primaryColor1 : Colors.white,
                  textColor: controller.exerciseLevel.value == Constant.EXC_ACTIVE_little ? Colors.white : Colors.black,
                  iconAssets: 'assets/images/sedentary.png',
                  onTap: () {
                    changeStatus(0);
                    controller.exerciseLevel.value = Constant.EXC_ACTIVE_little;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SimpleButtonCard(
                  buttonText: "Moderately active",
                  backgroundColor: controller.exerciseLevel.value == Constant.EXC_ACTIVE_light ? AppColor.primaryColor1 : Colors.white,
                  textColor: controller.exerciseLevel.value == Constant.EXC_ACTIVE_light ? Colors.white : Colors.black,
                  iconAssets: 'assets/images/teacher.png',
                  extraText: 'I spend a good part of the day on my feet. E.g teacher, salesperson',
                  onTap: () {
                    changeStatus(1);
                    controller.exerciseLevel.value = Constant.EXC_ACTIVE_light;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SimpleButtonCard(
                  buttonText: "Active",
                  backgroundColor: controller.exerciseLevel.value == Constant.EXC_ACTIVE_moderate ? AppColor.primaryColor1 : Colors.white,
                  textColor: controller.exerciseLevel.value == Constant.EXC_ACTIVE_moderate ? Colors.white : Colors.black,
                  iconAssets: 'assets/images/waiter.png',
                  extraText: 'I spend a good part of the day walking or doing some physical activity. E.g waiter, nurse',
                  onTap: () {
                    changeStatus(2);
                    controller.exerciseLevel.value = Constant.EXC_ACTIVE_moderate;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SimpleButtonCard(
                  buttonText: "Very active",
                  backgroundColor: controller.exerciseLevel.value == Constant.EXC_ACTIVE_heavy ? AppColor.primaryColor1 : Colors.white,
                  textColor: controller.exerciseLevel.value == Constant.EXC_ACTIVE_heavy ? Colors.white : Colors.black,
                  iconAssets: 'assets/images/very_active.png',
                  extraText: 'I spend most of the day doing heavy physical work or activity. E.g carpenter, construction worker',
                  onTap: () {
                    changeStatus(3);
                    controller.exerciseLevel.value = Constant.EXC_ACTIVE_heavy;
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
                          if (Get.parameters["type"] == "EditProfile") {
                            controller.handleUpdate();
                          } else {
                            onTap();
                          }
                        },
                        height: 50,
                        bgColor: AppColor.blackText,
                        textString: Get.parameters["type"] == "EditProfile" ? "Update" : 'Sign up',
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
