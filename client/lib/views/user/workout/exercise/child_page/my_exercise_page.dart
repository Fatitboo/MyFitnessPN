import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../exercise_controller.dart';

class MyExercisePage extends GetView<ExerciseController> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("My exercise"),
          ElevatedButton(onPressed: () {
            controller.getAllExercise("660779c774cb604465279dcf");
          }, child: Text("get data"))
        ],
      ),
    );
  }
}