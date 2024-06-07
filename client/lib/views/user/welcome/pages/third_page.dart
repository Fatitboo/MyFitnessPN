import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';
import '../../../../res/widgets/my_button.dart';
import '../welcome_controller.dart';

class ThirdPage extends GetView<WelcomeController> {
  final VoidCallback onTap;
  final VoidCallback back;
  var selectedIndex = 3.obs;

  ThirdPage({super.key, required this.onTap, required this.back});

  void changeStatus(var index) {
    selectedIndex.value = index;
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != controller.selectedDate.value) {

      controller.selectedDate.value = picked;
    }
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
            "What is your birthday?",
            style: TextStyle(
                color: AppColor.blackText,
                fontSize: 24,
                fontFamily: 'Gothic',
                fontWeight: FontWeight.w900),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${controller.selectedDate.value.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Input your birthday')),
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
