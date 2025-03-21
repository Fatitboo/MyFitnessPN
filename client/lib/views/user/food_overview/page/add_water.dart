import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/food_overview/add_food/add_food_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogWaterPage extends GetView<AddFoodController> {
  const LogWaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title:  Text(controller.title.value),
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  controller.logWater();
                },
                icon: const Icon(Icons.check))
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Water (ml)",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: controller.formController["water"],
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "250"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade300,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
