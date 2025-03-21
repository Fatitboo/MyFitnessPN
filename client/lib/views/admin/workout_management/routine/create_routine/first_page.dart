import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/my_button.dart';
import '../../../../../validate/Validator.dart';

class FirstPage extends GetView<RoutineController> {
  FirstPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;
  var selectedIndex = 3.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height + 50,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 100),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor3,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Routine Basic", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          const SizedBox(width: 10,),
                          Image.asset("assets/images/routineBasic.png",height: 120,)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text("Routine Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                      const SizedBox(height: 5,),
                      TextField(
                        controller: controller.textEditController["routineName"],
                        decoration: InputDecoration(
                          hintText: "Required",
                          errorText: controller.errors["routineName"]!.isError ? controller.errors["routineName"]!.message : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          )
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text("Duration (minutes)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                      const SizedBox(height: 5,),
                      TextField(
                        controller: controller.textEditController["duration"],
                        decoration: InputDecoration(
                            hintText: "Required",
                            errorText: controller.errors["duration"]!.isError ? controller.errors["duration"]!.message : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            )
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text("Level", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black54),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    controller.selectedType.value,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  items: controller.routineTypes.map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  )).toList(),
                                  value: controller.selectedType.value,
                                  onChanged: (String? value) {
                                    controller.onChangeValueDropdownRoutineType(value!);
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                    elevation: 0,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text("Category", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black54),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    controller.selectedCategory.value,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  items: controller.categoryTypesList.map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  )).toList(),
                                  value: controller.selectedCategory.value,
                                  onChanged: (String? value) {
                                    print(value);
                                    controller.onChangeValueDropdownRoutineCategory(value!);
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                    elevation: 0,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft, child: Row(
                          children: [
                            Text("Workout overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                              // if(controller.errors.value["workoutOverview"]!.isError)
                              // Text(" (${controller.errors.value["workoutOverview"]!.message})", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.redAccent),),
                              //
                          ],
                        )),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: const ShapeDecoration(
                                  color: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black54),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                  ),
                                ),
                                child: QuillToolbar.simple(
                                  configurations: QuillSimpleToolbarConfigurations(
                                      controller: controller.workoutOverviewController,
                                      sharedConfigurations: const QuillSharedConfigurations(
                                        locale: Locale('de'),
                                      ),
                                      showFontSize: false,
                                      showCodeBlock: false,
                                      showUnderLineButton: false,
                                      showBackgroundColorButton: false,
                                      showBoldButton: false,
                                      showCenterAlignment: false,
                                      showFontFamily: false,
                                      showLink: false,
                                      showHeaderStyle: false,
                                      showItalicButton: false,
                                      showDividers: false,
                                      showListCheck: false,
                                      showListNumbers: false,
                                      showColorButton: false,
                                      showQuote: false,
                                      showStrikeThrough: false,
                                      showSearchButton: false,
                                      showInlineCode: false,
                                      showSuperscript: false,
                                      showSubscript: false,
                                      showJustifyAlignment: false,
                                      showSmallButton: false,
                                      showDirection: false,
                                      showClearFormat: false
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black54),
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
                              ),
                            ),
                            child: QuillEditor.basic(
                              configurations: QuillEditorConfigurations(
                                controller: controller.workoutOverviewController,
                                // readOnly: false,
                                sharedConfigurations: const QuillSharedConfigurations(
                                  locale: Locale('de'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: MyButton(
                    onTap: () {
                      controller.errors.value = Validator.ValidateForm(controller.validate.value, controller.textEditController.value);
                      var result = controller.errors.values.toList().firstWhere((e) => e.isError, orElse: () => Val(false, ""));
                      if(!result.isError){
                        print("do2");
                        if(controller.workoutOverviewController.document.toPlainText().trim().isEmpty){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              AlertDialog alert = AlertDialog(
                                title: Text("Warning"),
                                content: Text("Workout overview is requires!"),
                                actions: [
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                              return alert;
                            },
                          );
                        }
                        else{
                          print("do3q");

                          onTap();
                        }
                      }

                      print("do4");

                    },
                    bgColor: AppColor.blackText,
                    textString: 'Next',
                    textColor: Colors.white,
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