
import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/res/widgets/loading_widget.dart';
import 'package:do_an_2/views/admin/workout_management/exercise/exercise_controller.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:do_an_2/views/admin/workout_management/video_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../res/values/constants.dart';
import '../../../../data/network/cloudinary.dart';
import '../../../../res/routes/names.dart';
import '../../../../res/values/color_extension.dart';

class MyExercisePage extends GetView<ExerciseController> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar:
        controller.fromPage.value == "add-routine" ?
          AppBar(
            title: const Text("Select an exercise"),
          ) : null,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: LoadingWidget(loading: controller.loading.value)),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.myExercises.value.length,
                  itemBuilder: (BuildContext ct, int index) {
                    ExerciseDTO exerciseDTO = controller.myExercises.value.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        if(controller.fromPage.value == "add-routine"){
                          Get.find<RoutineController>().addExerciseToList(exerciseDTO);
                          Get.back();
                        }
                      },
                      onTapDown: (position){
                        if(controller.from.value == "routine"){
                          Get.back(result: controller.myExercises[index].name);
                        }
                        final RenderBox renderBox = context.findRenderObject() as RenderBox;
                        controller.tapPosition.value = renderBox.globalToLocal(position.globalPosition);
                      },
                      onLongPress: () {
                        final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();
                        if(controller.fromPage.value != "add-routine"){
                          final result = showMenu(
                            context: ct,
                            color: Colors.white,
                            items: <PopupMenuEntry> [
                              PopupMenuItem(
                                onTap: () async{
                                  controller.selected = exerciseDTO;
                                  Get.toNamed(AppRoutes.WORKOUT_MANAGEMENT_ADD, arguments: {"type": "edit"})?.then(
                                          (value) => {
                                        controller.resetValue()
                                      }
                                  );
                                },
                                child: const Text("Edit"),
                              ),
                              PopupMenuItem(
                                onTap: () async{
                                  print(exerciseDTO.id);
                                   bool isSuccess = await CloudinaryNetWork().delete(exerciseDTO.video!, Constant.FILE_TYPE_video);
                                   if(isSuccess){
                                     controller.deleteExercise(exerciseDTO.id ?? "", index);
                                   }
                                },
                                child: const Text("Delete"),
                              )

                            ],
                            position: RelativeRect.fromRect(
                              Rect.fromLTWH(controller.tapPosition.value.dx, controller.tapPosition.value.dy, 10, 10),
                              Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width, overlay!.paintBounds.size.height),
                            ),
                          );
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                exerciseDTO.type == Constant.EXERCISE_strength.toLowerCase() ? Image.asset("assets/icons/gainweight.png", height: 20, width: 20,):
                                Image.asset("assets/icons/cardio.png", height: 20, width: 20,),
                                const SizedBox(width: 17,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(exerciseDTO.name!, style: const TextStyle(fontSize: 16),),
                                    SizedBox(width: MediaQuery.of(context).size.width - 100 ,child: Text(exerciseDTO.instruction!, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54),))
                                  ],
                                ),
                              ],
                            ),
                            if(exerciseDTO.video != "")
                              GestureDetector(
                                child: const Icon(
                                  Icons.info_rounded,
                                  size: 14,
                                  color: Colors.black54,
                                ),
                                onTap: () {
                                  Get.to(() => VideoPreview(videoUrl: exerciseDTO.video!));
                                },
                              )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
            if(controller.fromPage.value == "workout")
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
                          Get.toNamed(AppRoutes.WORKOUT_MANAGEMENT_ADD, arguments: {"type": "add"})?.then(
                                  (value) => {
                                controller.resetValue()
                              }
                          );
                        },
                        child: Text("Create an Exercise", style: TextStyle(fontSize: 16, color: AppColor.OutlineButtonColor),)
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}