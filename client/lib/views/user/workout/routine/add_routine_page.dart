import 'dart:convert';

import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/workout/routine/add_exercise_item.dart';
import 'package:do_an_2/views/user/workout/routine/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/constants.dart';
import '../../../../validate/Validator.dart';

class AddRoutinePage extends GetView<RoutineController>{
  const AddRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(controller.typeForm.value == "update" ? "Edit Routine" : "Build Routine"),
            ElevatedButton(
              onPressed: () async {
                controller.errors.value = Validator.ValidateForm(controller.validate.value, controller.textEditController.value);
                var result = controller.errors.value.values.toList().firstWhere((e) => e.isError, orElse: () => Val(false, ""));
                bool isErrorExes = false;
                for(int i = 0; i < controller.errorExes.value.length; i++){
                  for(int j = 0; j < controller.errorExes.value[i]["sets"].length; j++){
                    controller.errorExes.value[i]["sets"][j] = Validator.ValidateForm(controller.validateExes.value[i]["sets"][j], controller.textEditExercise.value[i]["sets"][j]);
                    var resultExes = controller.errorExes.value[i]["sets"][j].values.toList().firstWhere((e) => (e as Val).isError, orElse: () => Val(false, ""));
                    if(resultExes.isError) {
                      isErrorExes = true;
                    }
                  }
                }
                if(!result.isError && !isErrorExes){
                  List<dynamic> exes = [];
                  for(int i = 0; i < controller.textEditExercise.length; i++){
                    List<dynamic> sets = [];
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

                  var obj = {
                    "routineName": controller.textEditController["routineName"]?.text,
                    "description": controller.textEditController["description"]?.text,
                    "plannedVolume": double.parse(controller.textEditController["plannedVolume"]!.text),
                    "duration": double.parse(controller.textEditController["duration"]!.text),
                    "caloriesBurned": double.parse(controller.textEditController["caloriesBurned"]!.text),
                    "exercises": exes
                  };
                  if(controller.typeForm.value == "update"){
                    if(await controller.updateRoutine(jsonEncode(obj), obj)){
                      Get.back();
                    }
                  }
                  else{
                    if(await controller.createRoutine(jsonEncode(obj))){
                      Get.back();
                    }
                  }
                }

              }
            , child: Text(controller.typeForm.value == "update" ? "Update" : "Add"))
          ],
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: controller.textEditController["routineName"],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorText: controller.errors["routineName"]!.isError ? controller.errors["routineName"]!.message : null,
                    isDense: true,
                    contentPadding: EdgeInsets.all(0),
                    // contentPadding: EdgeInsets.only(bottom: 0),
                    hintText: 'Routine Name',
                    hintStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.grey),
                  ),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black87),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: controller.textEditController["description"],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add description or notes...',
                    hintStyle: TextStyle(color: Colors.grey,),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                height: 1,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        children: [
                          SizedBox(
                            width: width / 4,
                            child: TextField(
                              controller: controller.textEditController["plannedVolume"],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.all(0),
                                errorText: controller.errors["plannedVolume"]!.isError ? controller.errors["plannedVolume"]!.message : null,
                                hintText: '-',
                              ),
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          const Text("Planned Volume", style: TextStyle(color: Color(0xff707070)),)
                        ]
                    ),
                    Column(
                        children: [
                          SizedBox(
                            width:  width / 4,
                            child: TextField(
                              controller: controller.textEditController["duration"],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.all(0),
                                errorText: controller.errors["duration"]!.isError ? controller.errors["duration"]!.message : null,
                                hintText: '-',
                              ),
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          const Text("Est. Duration", style: TextStyle(color: Color(0xff707070)),)
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 4,
                            child: TextField(
                              controller: controller.textEditController["caloriesBurned"],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '-',
                                isDense: true,
                                contentPadding: const EdgeInsets.all(0),
                                errorText: controller.errors["caloriesBurned"]!.isError ? controller.errors["caloriesBurned"]!.message : null,
                                // counterText: ""
                              ),
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          const Text("Est. Calories", style: TextStyle(color: Color(0xff707070)),)
                        ]
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  color: const Color(0xffdadcdc),
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.textEditExercise.value.length,
                      itemBuilder: (BuildContext ct, int index) {
                        return AddExerciseItem(controller: controller, index: index,);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // controller.addExercise();
                          Get.toNamed(AppRoutes.EXERCISE, arguments: {"type": Constant.EXERCISE_strength, "from": "routine"}, preventDuplicates: false)
                          ?.then((value) => {
                            if(value != null){
                              controller.addExercise(value)
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          decoration: BoxDecoration(
                            color: AppColor.OutlineButtonColor,
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: const Text(
                            "Add Exercise",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    ));
  }


}