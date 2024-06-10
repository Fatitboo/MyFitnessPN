import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/views/admin/workout_management/exercise/exercise_controller.dart';
import 'package:do_an_2/views/admin/workout_management/exercise/exercise_page.dart';
import 'package:do_an_2/views/admin/workout_management/routine/add_exercise_item.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/my_button.dart';
import '../../../../../validate/Validator.dart';

class FourthPage extends GetView<RoutineController> {
  final VoidCallback back;
  final VoidCallback onTap;
  const FourthPage({super.key,  required this.back, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height + 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   decoration: BoxDecoration(
                //     color: AppColor.primaryColor3,
                //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                //   ),
                //   child: SingleChildScrollView(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         const Text("Exercises", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                //         const SizedBox(width: 10,),
                //         Image.asset("assets/images/routineExercises.png",height: 120,)
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: MyButton(
                        onTap: () {
                          ExerciseDTO exeDTO = ExerciseDTO.init();
                          exeDTO.name = "REST";
                          exeDTO.type = "cardio";
                          exeDTO.id = "rest";
                          controller.addExerciseToList(exeDTO);
                        },
                        bgColor: AppColor.blackText,
                        textString: 'Rest',
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 1,
                                    color: AppColor.OutlineButtonColor
                                )
                            ),
                            onPressed: () {
                              Get.find<ExerciseController>().setFromPage("add-routine");
                              Get.to(() => MyExercisePage());
                            },
                            child: Text("Add Exercise", style: TextStyle(fontSize: 16, color: AppColor.OutlineButtonColor),)
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listExercises.value.length,
                      itemBuilder: (BuildContext ct, int index) {
                         //return Text(controller.listExercises.value.elementAt(index).name.toString());
                        ExerciseDTO exerciseDTO = controller.listExercises.elementAt(index);
                        return AddExerciseItem(indexItem: index,exercise: exerciseDTO);
                      },
                    ),
                ),

                Container(height: 80,)
              ],
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
                              onTap: () {
                                bool isErrorExes = false;
                                for(int i = 0; i < controller.errorExes.value.length; i++){
                                  if(controller.errorExes.value[i]["sets"] != null){
                                    for(int j = 0; j < controller.errorExes.value[i]["sets"].length; j++){
                                      controller.errorExes.value[i]["sets"][j] = Validator.ValidateForm(controller.validateExes.value[i]["sets"][j], controller.textEditExercise.value[i]["sets"][j]);
                                      var resultExes = controller.errorExes.value[i]["sets"][j].values.toList().firstWhere((e) => (e as Val).isError, orElse: () => Val(false, ""));
                                      if(resultExes.isError) {
                                        isErrorExes = true;
                                      }
                                    }
                                  }
                                  else{
                                    controller.errorExes.value[i] = Validator.ValidateForm(controller.validateExes.value[i], controller.textEditExercise.value[i]);
                                    if(controller.errorExes.value[i]["minutes"].isError) {
                                      isErrorExes = true;
                                    }
                                  }
                                }
                                controller.errorExes.refresh();
                                controller.listExercises.refresh();
                                if(!isErrorExes){
                                  onTap();
                                  // List<dynamic> exes = [];
                                  // for(int i = 0; i < controller.textEditExercise.length; i++){
                                  //   List<dynamic> sets = [];
                                  //   for(int j = 0; j < controller.textEditExercise[i]["sets"].length; j++){
                                  //     var itemSet = {
                                  //       "weight": double.parse(controller.textEditExercise[i]["sets"][j]["weight"].text),
                                  //       "rep": int.parse(controller.textEditExercise[i]["sets"][j]["rep"].text),
                                  //       "count": 1
                                  //     };
                                  //     sets.add(itemSet);
                                  //   }
                                  //   var itemExe = {
                                  //     "name": controller.textEditExercise[i]["name"].text,
                                  //     "type": Constant.EXERCISE_strength.toLowerCase(),
                                  //     "instruction": controller.textEditExercise[i]["instruction"].text,
                                  //     "sets": sets
                                  //   };
                                  //   exes.add(itemExe);
                                  // }
                                  //
                                  // var obj = {
                                  //   "routineName": controller.textEditController["routineName"]?.text,
                                  //   "description": controller.textEditController["description"]?.text,
                                  //   "plannedVolume": double.parse(controller.textEditController["plannedVolume"]!.text),
                                  //   "duration": double.parse(controller.textEditController["duration"]!.text),
                                  //   "caloriesBurned": double.parse(controller.textEditController["caloriesBurned"]!.text),
                                  //   "exercises": exes
                                  // };
                                  // if(controller.typeForm.value == "update"){
                                  //   if(await controller.updateRoutine(jsonEncode(obj), obj)){
                                  //     Get.back();
                                  //   }
                                  // }
                                  // else{
                                  //   if(await controller.createRoutine(jsonEncode(obj))){
                                  //     Get.back();
                                  //   }
                                  // }
                                }
                              },
                              bgColor: AppColor.blackText,
                              textString: 'Next',
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
