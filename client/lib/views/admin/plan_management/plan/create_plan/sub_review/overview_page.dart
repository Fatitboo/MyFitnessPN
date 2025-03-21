import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class OverviewPage extends GetView<PlanAdminController>{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: controller.overviewController,
                // readOnly: true,
                checkBoxReadOnly: true,
                sharedConfigurations: const QuillSharedConfigurations(
                  locale: Locale('de'),
                ),
              ),
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Duration", style: TextStyle(fontSize: 16),),
                Text("${int.parse(controller.textEditController.value["duration"]!.text) * 7} days", style: const TextStyle(fontSize: 16),)
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Times Per Week", style: TextStyle(fontSize: 16),),
                controller.selectedTimePerWeek.value == "7" ?
                const Text("Daily", style: TextStyle(fontSize: 16),)
                :
                Text("${controller.selectedTimePerWeek.value}x a week", style: const TextStyle(fontSize: 16),)
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Difficulty", style: TextStyle(fontSize: 16),),
                Text(controller.selectedDifficulty.value, style: const TextStyle(fontSize: 16),)
              ],
            ),
            const SizedBox(height: 15,),
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
                    const SizedBox(height: 15,),
                    Text(quillController.keys.elementAt(0), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
                    const SizedBox(height: 5,),
                    QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: quillController.values.elementAt(0),
                        // readOnly: true,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('de'),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }
}