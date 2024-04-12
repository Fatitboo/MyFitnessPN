import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'workout_management_controller.dart';


class WorkoutManagementPage extends GetView<WorkoutManagementController> {
  const WorkoutManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Workout management'),
    );
  }
}
