import 'dart:convert';

import 'package:do_an_2/views/user/workout/exercise/exercise_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../model/exerciseDTO.dart';
import '../../../../../res/values/color_extension.dart';
import '../../../../../res/values/constants.dart';
import '../../../../../res/widgets/loading_widget.dart';
import '../../../../../validate/Validator.dart';
import '../../../../../validate/error_type.dart';
import 'package:do_an_2/model/components/set.dart';

class ExerciseForm extends StatefulWidget{
  const ExerciseForm({super.key, required this.context, required this.exerciseController, required this.typeForm});
  final BuildContext context;
  final ExerciseController exerciseController;
  final String typeForm;
  @override
  State<ExerciseForm> createState() => _AddExerciseFormState();
}

class _AddExerciseFormState extends State<ExerciseForm> {
  Map<String, TextEditingController> formController = {
    "description": TextEditingController(),
    "sets": TextEditingController(),
    "reps": TextEditingController(),
    "weight": TextEditingController(),
    "caloriesBurned": TextEditingController(),
    "minutes": TextEditingController(),
  };
  late bool isStrength;
  late Map<String, Map<String, String>> validate;
  Map<String, Val> errors = {
    "description": Val(false, ""),
    "sets": Val(false, ""),
    "reps": Val(false, ""),
    "weight": Val(false, ""),
    "caloriesBurned": Val(false, ""),
    "minutes": Val(false, "")
  };

  @override
  void initState() {
    isStrength = widget.exerciseController.currentWorkoutType.toLowerCase() == Constant.EXERCISE_strength.toLowerCase();
    if(isStrength) {
      validate = {
        "description": {
          ERROR_TYPE.require: "Description is required"
        },
        "sets": {
          ERROR_TYPE.require: "Number of sets is required",
          ERROR_TYPE.number: "Sets must be a number",
        },
        "reps": {
          ERROR_TYPE.require: "Number of repetitions is required",
          ERROR_TYPE.number: "Repetition must be a number",
        },
        "weight": {
          ERROR_TYPE.require: "Number of weight is required",
          ERROR_TYPE.number: "Repetition must be a number",
        },
        "caloriesBurned": {
          ERROR_TYPE.require: "Number of calories is required",
          ERROR_TYPE.number: "Repetition must be a number",
        },
      };
      if(widget.typeForm == "log"){
        formController["description"]!.text = widget.exerciseController.selected.name!;
        formController["sets"]!.text = widget.exerciseController.selected.sets![0].count.toString();
        formController["reps"]!.text = widget.exerciseController.selected.sets![0].rep.toString();
        formController["weight"]!.text = widget.exerciseController.selected.sets![0].weight.toString();
        formController["caloriesBurned"]!.text = widget.exerciseController.selected.caloriesBurn.toString();
      }
    }
    else{
      validate = {
        "description": {
          ERROR_TYPE.require: "Description is required"
        },
        "caloriesBurned": {
          ERROR_TYPE.require: "Number of calories is required",
          ERROR_TYPE.number: "Repetition must be a number",
        },
        "minutes": {
          ERROR_TYPE.require: "Time is required",
          ERROR_TYPE.number: "Repetition must be a number",
        },
      };
      if(widget.typeForm == "log"){
        formController["description"]!.text = widget.exerciseController.selected.name!;
        formController["caloriesBurned"]!.text = widget.exerciseController.selected.caloriesBurn.toString();
        formController["minutes"]!.text = widget.exerciseController.selected.minutes.toString();
      }
    }


  }

  @override
  Widget build(BuildContext ct) {
    //Get.lazyPut<ExerciseController>(() => ExerciseController());
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: AppColor.white,
          shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Row(
            children: [
              const Text("New Exercise", style: TextStyle(fontWeight: FontWeight.w500),),
              Obx(() => LoadingWidget(loading: widget.exerciseController.loading.value))
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(widget.context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: formController["description"],
                  onChanged: (item) {
                    setState(() {
                      errors["description"]?.isError = false;
                    });
                  },
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    errorText: errors["description"]!.isError ? errors["description"]!.message : null,
                    hintText: 'Description*',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                isStrength ?
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("# of Sets"),
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(widget.context).size.width / 4),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: formController["sets"],
                                onChanged: (item) {
                                  setState(() {
                                    errors["sets"]?.isError = false;
                                  });
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: errors["sets"]!.isError ? errors["sets"]!.message : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Required"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Reps/Set"),
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(widget.context).size.width / 4),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: formController["reps"],
                                onChanged: (item) {
                                  setState(() {
                                    errors["reps"]?.isError = false;
                                  });
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorText: errors["reps"]!.isError ? errors["reps"]!.message : null,
                                    hintText: "Required"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Weight/Rep"),
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(widget.context).size.width / 4),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: formController["weight"],
                                onChanged: (item) {
                                  setState(() {
                                    errors["weight"]?.isError = false;
                                  });
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorText: errors["weight"]!.isError ? errors["weight"]!.message : null,
                                    hintText: "Optional"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                    :
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("How long (minutes)?"),
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(widget.context).size.width / 4),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: formController["minutes"],
                                onChanged: (item) {
                                  setState(() {
                                    errors["minutes"]?.isError = false;
                                  });
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: errors["minutes"]!.isError ? errors["minutes"]!.message : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Required"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Calories Burned"),
                    Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(widget.context).size.width / 4),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: formController["caloriesBurned"],
                          onChanged: (item) {
                            setState(() {
                              errors["caloriesBurned"]?.isError = false;
                            });
                          },
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorText: errors["caloriesBurned"]!.isError ? errors["caloriesBurned"]!.message : null,
                              hintText: "Optional"
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(widget.context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            errors = Validator.ValidateForm(validate, formController);
                            var result = errors.values.toList().firstWhere((e) => e.isError, orElse: () => Val(false, ""));
                            Object obj;
                            var item;
                            ExerciseDTO exeDTO = ExerciseDTO.init();
                            exeDTO.name = formController["description"]!.text;
                            exeDTO.type = widget.exerciseController.currentWorkoutType.value.toLowerCase();
                            exeDTO.caloriesBurn = double.parse(formController["caloriesBurned"]!.text);
                            if(!result.isError){
                              if(isStrength){
                                List<Set> sets = [Set(
                                  weight: double.parse(formController["weight"]!.text),
                                  rep: int.parse(formController["reps"]!.text),
                                  count: int.parse(formController["sets"]!.text),
                                )];
                                item = {
                                  "name": exeDTO.name,
                                  "type": exeDTO.type,
                                  "sets": [{
                                    "weight": sets[0].weight,
                                    "rep": sets[0].rep,
                                    "count": sets[0].count
                                  }],
                                  "caloriesBurn": exeDTO.caloriesBurn,
                                };
                                exeDTO.sets = sets;
                              }
                              else{
                                exeDTO.minutes = double.parse(
                                    formController["minutes"]!.text);
                                item = {
                                  "name": exeDTO.name,
                                  "type": exeDTO.type,
                                  "minutes":  exeDTO.minutes,
                                  "caloriesBurn": exeDTO.caloriesBurn,
                                };
                              }
                              if(widget.typeForm == "log"){
                                exeDTO.id = widget.exerciseController.selected.id!;
                                item["exeId"] = exeDTO.id;
                                obj = jsonEncode(item);
                                if(await widget.exerciseController.logExercise(exeDTO, obj, widget.exerciseController.selected.id!)){
                                  Navigator.pop(ct);
                                }
                              }
                              else{
                                obj = jsonEncode(item);
                                if(await widget.exerciseController.createExercise(obj)){
                                  Navigator.pop(ct);
                                }
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor1,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(
                              widget.typeForm == "log" ? "Log exercise" : "Add Exercise",
                              style: const TextStyle(color: Colors.white),
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
          )
        ),
      ),
    );
  }
}

