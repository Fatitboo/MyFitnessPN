import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RoutineExploreItemUserWidget extends StatelessWidget{

  final String routId;
  final String thumbNail;
  final String routineName;
  final String duration;
  final String type;
  final String category;
  final QuillController workoutOverview;
  final Function callBack;

  const RoutineExploreItemUserWidget({super.key, required this.routId, required this.routineName, required this.duration, required this.callBack, required this.thumbNail, required this.type, required this.category, required this.workoutOverview});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]
        ),
        width: MediaQuery.of(context).size.width - 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)), child: Image.network(thumbNail, height: 160, fit: BoxFit.cover,)),
            const SizedBox(width: 6,),
            Container(
              padding: const EdgeInsets.all(13),
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
                                Icon(
                                  Icons.alarm,
                                  color: Colors.black.withOpacity(0.6),
                                  size: 18,
                                ),
                                const SizedBox(width: 5,),
                                Text("$duration:00  |  ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.6)),),
                                SizedBox(width: 100,child: Text(type, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.6)),)),
                              ],
                            ),
                            SizedBox(width: (MediaQuery.of(context).size.width - 130) ,child: Text(routineName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 3,),
                    SizedBox(
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          maxHeight: 45,
                          controller: workoutOverview,
                          // readOnly: true,
                          checkBoxReadOnly: true,
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
      // child: Text(routineName),
    );
  }
}