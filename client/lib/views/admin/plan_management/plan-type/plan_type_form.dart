import 'dart:convert';
import 'package:do_an_2/model/planTypeDTO.dart';
import 'package:do_an_2/views/admin/plan_management/plan_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/loading_widget.dart';
import '../../../../../validate/Validator.dart';
import '../../../../../validate/error_type.dart';

class PlanTypeForm extends StatefulWidget{
  const PlanTypeForm({super.key, required this.context, required this.planManagementController, required this.typeForm});
  final BuildContext context;
  final PlanManagementController planManagementController;
  final String typeForm;
  @override
  State<PlanTypeForm> createState() => _AddRoutineCategoryFormState();
}

class _AddRoutineCategoryFormState extends State<PlanTypeForm> {
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
      formController["name"]?.text = widget.planManagementController.selectedPlanType.value.name!;
      formController["description"]?.text = widget.planManagementController.selectedPlanType.value.description!;
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
                const Text("New Plan Type", style: TextStyle(fontWeight: FontWeight.w500),),
                Obx(() => LoadingWidget(loading: widget.planManagementController.loading.value))
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
                              PlanTypeDTO planTypeDTO = PlanTypeDTO.init();
                              planTypeDTO.name = formController["name"]!.text;
                              planTypeDTO.description = formController["description"]!.text;
                              if(!result.isError){
                                item = {
                                  "planTypeId": widget.planManagementController.selectedPlanType.value.planTypeId,
                                  "name": planTypeDTO.name,
                                  "description": planTypeDTO.description,
                                };
                                obj = jsonEncode(item);
                                if(widget.typeForm == "add"){
                                  if(await widget.planManagementController.createPlanType(obj)){
                                    Navigator.pop(ct);
                                  }
                                }
                                else{
                                  if(await widget.planManagementController.updatePlanType(obj, item)){
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
                                widget.typeForm == "add" ? "Add Type" : "Update Type",
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

