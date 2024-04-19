import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'meal_management_controller.dart';


class MealManagementPage extends GetView<MealManagementController> {
  const MealManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Meal management'),
    );
  }
}
