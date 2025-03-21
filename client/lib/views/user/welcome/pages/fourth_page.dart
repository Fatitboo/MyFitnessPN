import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';
import '../../../../res/widgets/my_button.dart';
import '../welcome_controller.dart';

class FourthWelcomePage extends GetView<WelcomeController> {
  final VoidCallback onTap;
  final VoidCallback back;

  FourthWelcomePage({super.key, required this.onTap, required this.back});

  List<RulerRange> rangesTall = [RulerRange(begin: 70, end: 200, scale: 1)];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "How tall are you?",
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
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: RulerPicker(
                    controller: controller.rulerTallPickerController.value,
                    onBuildRulerScaleText: (index, value) {
                      return value.toInt().toString();
                    },
                    ranges: rangesTall,
                    scaleLineStyleList: [
                      ScaleLineStyle(
                          color: AppColor.primaryColor1,
                          width: 2,
                          height: 40,
                          scale: 0),
                      ScaleLineStyle(
                          color: AppColor.primaryColor1,
                          width: 1,
                          height: 25,
                          scale: 5),
                      ScaleLineStyle(
                          color: AppColor.primaryColor1,
                          width: 0,
                          height: 0,
                          scale: -1),
                    ],
                    onValueChanged: (value) {
                      controller.height.value = value.toInt();
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    rulerMarginTop: 8,
                    marker: Container(
                        width: 8,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor2.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  "${controller.height} cm",
                  style: TextStyle(
                      color: AppColor.primaryColor1,
                      fontWeight: FontWeight.bold,
                      fontSize: 60),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 30.0.h, right: 30.w, left: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: 24.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                                color: AppColor.blackText,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.question_mark,
                              size: 16.0,
                              color: AppColor.white,
                            )),
                      ),
                      const Expanded(
                        child: Text(
                          "Don't worry if you don't know it precisely-you can change this later",
                          style: TextStyle(
                              color: AppColor.blackText,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
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
