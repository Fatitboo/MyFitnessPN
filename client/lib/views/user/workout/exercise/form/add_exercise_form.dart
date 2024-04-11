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

class AddExerciseForm extends StatefulWidget{
  const AddExerciseForm({super.key, required this.context, required this.exerciseController});
  final BuildContext context;
  final ExerciseController exerciseController;

  @override
  State<AddExerciseForm> createState() => _AddExerciseFormState();
}

class _AddExerciseFormState extends State<AddExerciseForm> {
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
                          onTap: () {
                            setState(() {
                              errors = Validator.ValidateForm(validate, formController);
                              var result = errors.values.toList().firstWhere((e) => e.isError, orElse: () => Val(false, ""));
                              if(!result.isError){
                                ExerciseDTO exeDTO;
                                if(isStrength){
                                  List<Set> sets = [
                                    Set(
                                      weight: double.parse(formController["weight"]!.text),
                                      rep: int.parse(formController["reps"]!.text),
                                      count: int.parse(formController["sets"]!.text),
                                    )
                                  ];
                                  exeDTO = ExerciseDTO.initStrength(
                                      formController["description"]!.text,
                                      widget.exerciseController.currentWorkoutType.value.toLowerCase(),
                                      sets,
                                      double.parse(formController["caloriesBurned"]!.text),
                                  );
                                }
                                else{
                                  exeDTO = ExerciseDTO.initCardio(
                                    formController["description"]!.text,
                                    formController["type"]!.text,
                                    double.parse(formController["minutes"]!.text),
                                    double.parse(formController["caloriesBurned"]!.text),
                                  );
                                }
                                widget.exerciseController.createExercise(exeDTO);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor1,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Text(
                              "Add Exercise",
                              style: TextStyle(color: Colors.white),
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

