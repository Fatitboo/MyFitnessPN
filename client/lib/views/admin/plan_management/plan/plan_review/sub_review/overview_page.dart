import 'dart:convert';

import 'package:do_an_2/model/components/Description.dart';
import 'package:do_an_2/model/planDTO.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class OverviewPage extends StatelessWidget{
  OverviewPage(this.planDTO);
  final PlanDTO planDTO;
  @override
  Widget build(BuildContext context) {
    QuillController overviewController =  QuillController.basic();
    overviewController.document = Document.fromJson(jsonDecode(planDTO.overview.toString()));

    return Container(
      margin: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: overviewController,
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
                Text("${planDTO.duration! * 7} days", style: const TextStyle(fontSize: 16),)
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Times Per Week", style: TextStyle(fontSize: 16),),
                planDTO.timePerWeek == 7 ?
                const Text("Daily", style: TextStyle(fontSize: 16),)
                :
                Text("${planDTO.timePerWeek}x a week", style: const TextStyle(fontSize: 16),)
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Difficulty", style: TextStyle(fontSize: 16),),
                Text(planDTO.difficulty!, style: const TextStyle(fontSize: 16),)
              ],
            ),
            const SizedBox(height: 15,),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: planDTO.descriptions!.length,
              itemBuilder: (BuildContext ct, int index) {
                Description description = planDTO.descriptions![index];

                QuillController descriptionController =  QuillController.basic();
                descriptionController.document = Document.fromJson(jsonDecode(description.content!));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15,),
                    Text(description.title!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
                    const SizedBox(height: 5,),
                    QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: descriptionController,
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