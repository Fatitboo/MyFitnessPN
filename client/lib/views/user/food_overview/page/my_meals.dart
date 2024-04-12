import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMealPage extends GetView<FoodOverviewController> {
  const MyMealPage({super.key});



  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('my meal'),
    );
  }
}