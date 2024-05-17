import 'dart:convert';

import 'package:do_an_2/model/foodCategoryDTO.dart';
import 'package:do_an_2/model/routineCategoryDTO.dart';
import 'package:do_an_2/views/admin/meal_management/meal_management_controller.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../model/exerciseDTO.dart';
import '../../../../../res/values/color_extension.dart';
import '../../../../../res/values/constants.dart';
import '../../../../../res/widgets/loading_widget.dart';
import '../../../../../validate/Validator.dart';
import '../../../../../validate/error_type.dart';
import 'package:do_an_2/model/components/set.dart';

class MealCategoryForm extends StatefulWidget{
  const MealCategoryForm({super.key, required this.context,  required this.typeForm, required this.mealManagementController});
  final BuildContext context;
  final MealManagementController mealManagementController;
  final String typeForm;
  @override
  State<MealCategoryForm> createState() => _AddMealCategoryFormState();
}

class _AddMealCategoryFormState extends State<MealCategoryForm> {
  Map<String, TextEditingController> formController = {
    "name": TextEditingController(),
    "description": TextEditingController(),
  };
  late Map<String, Map<String, String>> validate;
  Map<String, Val> errors = {
    "name": Val(false, ""),
    "description": Val(false, ""),
  };

  @override
  void initState() {
    validate = {
      "name": {
        ERROR_TYPE.require: "Name is required"
      },
      "description": {
        ERROR_TYPE.require: "Description is required",
      },
    };

    if(widget.typeForm == "edit"){
      formController["name"]?.text = widget.mealManagementController.selectedMealCategory.value.name!;
      formController["description"]?.text = widget.mealManagementController.selectedMealCategory.value.description!;
    }
  }
  @override
  Widget build(BuildContext ct) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
            backgroundColor: AppColor.white,
            shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Row(
              children: [
                 Text(widget.typeForm=='edit'?"Update Category":"New Category", style: TextStyle(fontWeight: FontWeight.w500),),
                Obx(() => LoadingWidget(loading: widget.mealManagementController.loading.value))
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(widget.context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: formController["name"],
                    onChanged: (item) {
                      setState(() {
                        errors["name"]?.isError = false;
                      });
                    },
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      errorText: errors["name"]!.isError ? errors["name"]!.message : null,
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: formController["description"],
                    keyboardType: TextInputType.multiline,
                    maxLines: null,

                    onChanged: (item) {
                      setState(() {
                        errors["description"]?.isError = false;
                      });
                    },
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      errorText: errors["description"]!.isError ? errors["description"]!.message : null,
                      hintText: 'Description',
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
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
                              MealCategoryDTO mealCatDTO = MealCategoryDTO.init();
                              mealCatDTO.name = formController["name"]!.text;
                              mealCatDTO.description = formController["description"]!.text;
                              if(!result.isError){
                                item = {
                                  "routCategoryId": widget.mealManagementController.selectedMealCategory.value.mealCategoryId,
                                  "name": mealCatDTO.name,
                                  "description": mealCatDTO.description,
                                };
                                obj = jsonEncode(item);
                                if(widget.typeForm == "add"){
                                  if(await widget.mealManagementController.createMealCategory(obj)){
                                    Navigator.pop(ct);
                                  }
                                }
                                else{
                                  if(await widget.mealManagementController.updateMealCategory(obj, item)){
                                    Navigator.pop(ct);
                                  }
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor1,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text(
                                widget.typeForm == "add" ? "Add Category" : "Update Category",
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

