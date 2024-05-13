import 'dart:convert';

import 'package:do_an_2/model/routineDTO.dart';
import 'package:do_an_2/views/admin/workout_management/exercise/exercise_controller.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:do_an_2/views/common_widgets/routine_explore_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../../res/routes/names.dart';
import '../../../../../res/widgets/loading_widget.dart';
import '../../../../res/values/color_extension.dart';

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
                      QuillController quill = QuillController.basic();
                      quill.document = Document.fromJson(jsonDecode(routineDTO.workoutOverview.toString()));
                      return GestureDetector(
                        child: Container(
                          color: Colors.white,
                          child: RoutineExploreItemWidget(
                            routId: routineDTO.routId ?? "",
                            routineName: routineDTO.routineName ?? "",
                            duration: routineDTO.duration.toString(),
                            thumbNail: routineDTO.thumbNail.toString(),
                            type: routineDTO.type.toString(),
                            category: routineDTO.category.toString(),
                            workoutOverview: quill,
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
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 1,
                                  color: AppColor.OutlineButtonColor
                              )
                          ),
                          onPressed: () {
                            controller.setCategoryTypesList();
                            Get.toNamed(AppRoutes.ROUTINE_MANAGEMENT_ADD)?.then(
                                    (value) => {
                                  Get.find<ExerciseController>().setFromPage("workout"),
                                  controller.resetValue()
                                }
                            );
                          },
                          child: Text("Create an Routine", style: TextStyle(fontSize: 16, color: AppColor.OutlineButtonColor),)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}