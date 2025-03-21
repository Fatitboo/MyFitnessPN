
import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/res/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../res/values/constants.dart';
import '../exercise_controller.dart';
import '../form/exercise_form.dart';

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
                itemBuilder: (BuildContext ct, int index) {
                  ExerciseDTO exerciseDTO = controller.myExercises.value.elementAt(index);
                  return GestureDetector(
                    onTapDown: (position){
                      if(controller.from.value == "routine"){
                        Get.back(result: controller.myExercises[index].name);
                      }
                      final RenderBox renderBox = context.findRenderObject() as RenderBox;
                      controller.tapPosition.value = renderBox.globalToLocal(position.globalPosition);
                    },
                    onLongPress: () {
                      final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();
                      final result = showMenu(
                          context: ct,
                          color: Colors.white,
                          items: <PopupMenuEntry> [
                            PopupMenuItem(
                              onTap: () async{
                                controller.selected = controller.myExercises.value[index];
                                await showDialog(
                                  context: context,
                                  builder: (context) => ExerciseForm(context: context, exerciseController: controller, typeForm: "log",)
                                );
                              },
                              child: const Text("Log"),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                controller.deleteExercise(exerciseDTO.id ?? "", index);
                              },
                              child: const Text("Delete"),
                            )

                          ],
                          position: RelativeRect.fromRect(
                              Rect.fromLTWH(controller.tapPosition.value.dx, controller.tapPosition.value.dy, 10, 10),
                              Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width, overlay!.paintBounds.size.height),
                          ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(exerciseDTO.name!, style: const TextStyle(fontSize: 16),),
                              exerciseDTO.type == Constant.EXERCISE_strength.toLowerCase() ?
                                  Text(exerciseDTO.getStringStrengthValues(), style: const TextStyle(color: Colors.black54),)
                              :
                                  Text(exerciseDTO.getStringCardioValues(), style: const TextStyle(color: Colors.black54),)
                            ],
                          ),
                        ],
                      ),
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