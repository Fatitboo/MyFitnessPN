import 'dart:convert';

import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../../data/network/cloudinary.dart';
import '../../../../../res/values/color_extension.dart';
import '../../../../../res/values/constants.dart';
import '../../../../../res/widgets/my_button.dart';
import '../exercise_item.dart';

class ReviewPage extends GetView<RoutineController>{
  final VoidCallback back;
  final VoidCallback onTap;
  const ReviewPage({super.key,  required this.onTap, required this.back});
  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height + 120,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 100),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child:
                      controller.thumbnail.value.path != '' ?
                      Image.file(controller.thumbnail.value, height: 200, fit: BoxFit.cover,)
                          : Container(height: 200, decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 1)
                      )
                      )
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                        color: Colors.grey,
                        size: 16,
                      ),
                      SizedBox(width: 5,),
                      Text("${controller.textEditController.value["duration"]!.text}:00  |  "),
                      Text(controller.selectedType.value)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(controller.textEditController.value["routineName"]!.text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: controller.descriptionController,
                      // readOnly: true,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('de'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text("Workout Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: controller.workoutOverviewController,
                      // readOnly: true,
                      checkBoxReadOnly: true,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('de'),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.textEditExercise.value.length,
                      itemBuilder: (BuildContext ct, int index) {
                        //return Text(controller.listExercises.value.elementAt(index).name.toString());
                        // ExerciseDTO exerciseDTO = controller.textEditExercise.value.elementAt(index);
                          return ExerciseItem(controller: controller, index: index,);
                      },
                    ),
                  ),
                ],
              ),

            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: MyButton(
                          onTap: () {
                            back();
                          },
                          bgColor: AppColor.white,
                          textString: 'Back',
                          textColor: AppColor.blackText,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          children: [
                            MyButton(
                              onTap: () async{
                                controller.loadingUpload.value = true;
                                List<dynamic> exes = [];
                                for(int i = 0; i < controller.textEditExercise.length; i++){
                                  List<dynamic> sets = [];
                                  if(controller.textEditExercise[i]["sets"] != null){
                                    for(int j = 0; j < controller.textEditExercise[i]["sets"].length; j++){
                                      var itemSet = {
                                        "weight": double.parse(controller.textEditExercise[i]["sets"][j]["weight"].text),
                                        "rep": int.parse(controller.textEditExercise[i]["sets"][j]["rep"].text),
                                        "count": 1
                                      };
                                      sets.add(itemSet);
                                    }
                                    var itemExe = {
                                      "name": controller.textEditExercise[i]["name"].text,
                                      "type": Constant.EXERCISE_strength.toLowerCase(),
                                      "instruction": controller.textEditExercise[i]["instruction"].text,
                                      "sets": sets
                                    };
                                    exes.add(itemExe);
                                  }
                                  else{
                                    var itemExe = {
                                      "name": controller.textEditExercise[i]["name"].text,
                                      "type": Constant.EXERCISE_strength.toLowerCase(),
                                      "instruction": controller.textEditExercise[i]["instruction"].text,
                                      "minutes": controller.textEditExercise[i]["minutes"].text
                                    };
                                    exes.add(itemExe);
                                  }
                                }

                                print("alo");

                                Map<String, dynamic> res = await CloudinaryNetWork().upload(Constant.CLOUDINARY_ADMIN_ROUTINE_VIDEO, controller.video!, Constant.FILE_TYPE_video);

                                print("1");
                                Map<String, dynamic> resThumbnail = await CloudinaryNetWork().upload(Constant.CLOUDINARY_ADMIN_ROUTINE_IMAGE, controller.thumbnail.value!, Constant.FILE_TYPE_image);

                                print("2");
                                if(res["isSuccess"]){
                                  if(resThumbnail["isSuccess"]){
                                    var obj = {
                                      "routineName": controller.textEditController["routineName"]?.text,
                                      "duration": double.parse(controller.textEditController["duration"]!.text),
                                      "type": controller.selectedType.value,
                                      "category": controller.listCategory.value.firstWhereOrNull((element) => controller.selectedCategory.value == element.name)?.routCategoryId ?? controller.selectedCategory.value,
                                      "workoutOverview": jsonEncode(controller.workoutOverviewController.document.toDelta().toJson()),
                                      "video": res["imageUrl"],
                                      "thumbNail": resThumbnail["imageUrl"],
                                      "description": jsonEncode(controller.descriptionController.document.toDelta().toJson()),
                                      "exercises": exes
                                    };

                                    if(await controller.createRoutine(jsonEncode(obj))){
                                      Get.back();
                                    }
                                  }
                                  else{
                                    print(res["message"]);
                                  }
                                }
                                else{
                                  print("alooooo");
                                  print(res["message"]);
                                }
                                controller.loadingUpload.value = false;
                              },
                              bgColor: AppColor.blackText,
                              textString: 'Create',
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}