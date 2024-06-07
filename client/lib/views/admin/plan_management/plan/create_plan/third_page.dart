import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/my_button.dart';

class ThirdPage extends GetView<PlanAdminController> {
  final VoidCallback onTap;
  final VoidCallback back;

  ThirdPage({super.key,  required this.onTap, required this.back});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
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
                          const Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          const SizedBox(width: 10,),
                          Image.asset("assets/images/routineDes.png",height: 120,)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.descriptionControllers.value.length,
                    itemBuilder: (BuildContext ct, int index) {
                      Map<String, QuillController> quillController = controller.descriptionControllers.value.elementAt(index);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(quillController.keys.elementAt(0), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                              GestureDetector(
                                child: Icon(
                                  Icons.close,
                                  size: 22,
                                ),
                                onTap: () {
                                  controller.descriptionControllers.value.removeAt(index);
                                  controller.descriptionTypes.add(quillController.keys.elementAt(0));
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
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
                                        controller: quillController.values.elementAt(0),
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
                          Container(
                            height: 150,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black54),
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
                              ),
                            ),
                            child: QuillEditor.basic(
                              configurations: QuillEditorConfigurations(
                                controller: quillController.values.elementAt(0),
                                // readOnly: false,
                                sharedConfigurations: const QuillSharedConfigurations(
                                  locale: Locale('de'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
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
                                "Add title",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: AppColor.black,
                                ),
                              ),
                              items: controller.descriptionTypes.value.map((String item) => DropdownMenuItem<String>(
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
                              // value: controller.selectedTimePerWeek.value,
                              onChanged: (String? value) {
                                // controller.selectedTimePerWeek.value = value!;
                                Map<String, QuillController> quillController = {};
                                quillController[value!] = QuillController.basic();
                                controller.descriptionControllers.add(quillController);
                                controller.descriptionTypes.value.remove(value);
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 160,
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

                  const SizedBox(height: 90,),
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
                              onTap: () {
                                if(controller.descriptionControllers.value.isEmpty){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      AlertDialog alert = AlertDialog(
                                        title: const Text("Warning"),
                                        content: const Text("Please add at least one item!"),
                                        actions: [
                                          TextButton(
                                            child: const Text("OK"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                      return alert;
                                    },
                                  );
                                  return;
                                }
                                for(int i = 0; i < controller.descriptionControllers.value.length; i++){
                                  if(controller.descriptionControllers.elementAt(i).values.elementAt(0).document.toPlainText().trim().isEmpty){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Warning"),
                                          content: Text("Description for ${controller.descriptionControllers.elementAt(i).keys.elementAt(0)} is requires!"),
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
                                    return;
                                  }
                                }
                                onTap();
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
