import 'dart:convert';

import 'package:do_an_2/model/routineDTO.dart';
import 'package:do_an_2/views/common_widgets/routine_item.dart';
import 'package:do_an_2/views/user/workout/routine/routine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../res/routes/names.dart';
import '../../../../../res/widgets/loading_widget.dart';

class MyRoutinePage extends GetView<RoutineController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: LoadingWidget(loading: controller.loading.value)),
            Expanded(
              child: ListView.builder(
                  itemCount: controller.myRoutineList.length,
                  itemBuilder: (BuildContext ct, int index) {
                    RoutineDTO routineDTO = controller.myRoutineList.value.elementAt(index);
                    return GestureDetector(
                      child: Container(
                        color: Colors.white,
                        child: RoutineItemWidget(
                          routId: routineDTO.routId ?? "",
                          routineName: routineDTO.routineName ?? "",
                          description: routineDTO.description ?? "",
                          plannedVolume: routineDTO.plannedVolume.toString(),
                          duration: routineDTO.duration.toString(),
                          caloriesBurned: routineDTO.caloriesBurned.toString(),
                          exercises: routineDTO.exercises ?? [],
                          callBack: (type) {
                            switch(type){
                              case "delete":
                                controller.deleteExercise(routineDTO.routId!, index);
                                break;
                              case "edit":
                                controller.setValue(controller.myRoutineList.value[index]);
                                Get.toNamed(AppRoutes.ADD_ROUTINE, arguments: {"type": "update"})?.then(
                                        (value) => {
                                      controller.resetValue()
                                    }
                                );
                                break;
                              case "duplicate":
                                controller.createRoutine(jsonEncode( routineDTO.toJson(routineDTO)));
                            }
                          },
                        ),
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      )
    );
  }
}