import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RoutineExploreItemTaskWidget extends StatelessWidget{

  final String routineName;
  final String duration;
  final String type;
  final String category;
  final String workoutOverview;
  final Function callBack;

  const RoutineExploreItemTaskWidget({super.key, required this.routineName, required this.duration, required this.callBack, required this.type, required this.category, required this.workoutOverview});

  @override
  Widget build(BuildContext context) {
    QuillController quill = QuillController.basic();
    quill.document = Document.fromJson(jsonDecode(workoutOverview));

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black.withOpacity(0.7))
            // boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.alarm,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                const SizedBox(width: 5,),
                                Text("$duration:00  |  "),
                                SizedBox(width: 100,child: Text(type, overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width - 90, child: Text(routineName, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 3,),
                    SizedBox(
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          checkBoxReadOnly: true,
                          maxHeight: 62,
                          controller: quill,
                          // readOnly: true,
                          sharedConfigurations: const QuillSharedConfigurations(
                            locale: Locale('de'),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ],
        )
    );
  }
}