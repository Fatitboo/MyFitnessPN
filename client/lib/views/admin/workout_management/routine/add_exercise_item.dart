import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';
enum SampleItem { Duplicate, Delete }

class AddExerciseItem extends GetView<RoutineController>{
  const AddExerciseItem({super.key, required this.indexItem, required this.exercise});

  final int indexItem;
  final ExerciseDTO exercise;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: exercise.id == "rest"? AppColor.primaryColor2 :Colors.white,
        border: Border.all(
          color: Colors.black54,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.textEditExercise[indexItem]["name"].text,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
                ),
                PopupMenuButton<SampleItem>(
                  color: Colors.white,
                  padding: const EdgeInsets.only(right: 0),
                  onSelected: (SampleItem item) {

                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                      padding: EdgeInsets.only(left: 20, right: 50),
                      value: SampleItem.Duplicate,
                      child: Text('Duplicate'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      padding: EdgeInsets.only(left: 20, right: 50),
                      value: SampleItem.Delete,
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if(exercise.id != "rest")
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextField(
                controller: controller.textEditExercise[indexItem]["instruction"],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Add description or notes...',
                  hintStyle: TextStyle(color: Colors.grey,),
                ),
              ),
            ),
          exercise.type == "strength" ?
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: controller.textEditExercise[indexItem]["sets"].length,
              itemBuilder: (BuildContext ct, int index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    children: [
                      Container(width: 15 ,child: Text("${index + 1}", style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),)),
                      const SizedBox(width: 15,),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          textAlign: TextAlign.right,
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller.textEditExercise[indexItem]["sets"][index]["weight"],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            errorText: controller.errorExes[indexItem]["sets"][index]["weight"]!.isError ? controller.errorExes[indexItem]["sets"][index]["weight"]!.message : null,
                            hintText: "kg",
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10)
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          textAlign: TextAlign.right,
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller.textEditExercise[indexItem]["sets"][index]["rep"],
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              hintText: "reps",
                              errorText: controller.errorExes[indexItem]["sets"][index]["rep"]!.isError ? controller.errorExes[indexItem]["sets"][index]["rep"]!.message : null,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10)
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          )
              :
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Duration", style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),),
              ),
              const SizedBox(width: 15,),
              SizedBox(
                width: 100,
                child: TextField(
                  textAlign: TextAlign.right,
                  controller: controller.textEditExercise.value[indexItem]["minutes"],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      hintText: "ms",
                      errorText: controller.errorExes[indexItem]["minutes"].isError ? controller.errorExes[indexItem]["minutes"].message : null,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10)
                  ),
                ),
              ),
            ],
          ),
          exercise.type == "strength" ?
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 1,
            color: Colors.grey,
          ) : Container(margin: const EdgeInsets.only(top: 10),),

          GestureDetector(
            onTap: () {
              controller.textEditExercise[indexItem]["sets"].add({
                "rep": TextEditingController(),
                "weight": TextEditingController()
              });
              controller.errorExes[indexItem]["sets"].add({
                "rep": Val(false, ""),
                "weight": Val(false, ""),
              });
              controller.validateExes[indexItem]["sets"].add({
                "weight": {
                  ERROR_TYPE.require: "Required",
                  ERROR_TYPE.number: "Type number!",
                },
                "rep": {
                  ERROR_TYPE.require: "Required",
                  ERROR_TYPE.number: "Type number!",
                },
              });
              controller.textEditExercise.refresh();
            },
            child:
            exercise.type == "strength" ?
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                child: Align(alignment: Alignment.centerLeft, child: Text("ADD SET",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColor.OutlineButtonColor),)),
              ) : Container(),
          ),
        ],
      ),
    ));
  }
}