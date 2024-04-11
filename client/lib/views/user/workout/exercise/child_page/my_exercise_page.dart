import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/res/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../res/values/constants.dart';
import '../exercise_controller.dart';

class MyExercisePage extends GetView<ExerciseController> {

  @override
  Widget build(BuildContext context) {

    return Obx(() => SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: LoadingWidget(loading: controller.loading.value)),
          Expanded(
            child: ListView.builder(
                itemCount: controller.myExercises.length,
                itemBuilder: (BuildContext context, int index) {
                  ExerciseDTO exerciseDTO = controller.myExercises.value.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exerciseDTO.name, style: const TextStyle(fontSize: 16),),
                        exerciseDTO.type == Constant.EXERCISE_strength.toLowerCase() ?
                            Text(exerciseDTO.getStringStrengthValues(), style: const TextStyle(color: Colors.black54),)
                        :
                            Text(exerciseDTO.getStringCardioValues(), style: const TextStyle(color: Colors.black54),)
                      ],
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    ));
  }
}