import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FoodOverviewPage extends GetView<FoodOverviewController> {
  const FoodOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){Get.back();},
                icon:const Icon(Icons.arrow_back),
              ),

            ),
        body: Column(
          children: [],
        ),
      ));
    });
  }
}
