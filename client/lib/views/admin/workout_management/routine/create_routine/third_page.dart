import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/my_button.dart';

class ThirdPage extends GetView<RoutineController> {
  final VoidCallback onTap;
  final VoidCallback back;

  ThirdPage({super.key,  required this.onTap, required this.back});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
            const Align(alignment: Alignment.centerLeft, child: Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
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
                        controller: controller.descriptionController,
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
                    controller: controller.descriptionController,
                    // readOnly: false,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('de'),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
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
                                  if(controller.descriptionController.document.toPlainText().trim().isEmpty){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Warning"),
                                          content: Text("Description is requires!"),
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
                                    onTap();
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
      ),
    );
  }
}
