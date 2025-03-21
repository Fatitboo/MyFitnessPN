import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../res/routes/names.dart';

enum SampleItem { Delete, Duplicate, Edit, Log, Share}

class RoutineExploreItemWidget extends StatelessWidget{

  final String routId;
  final String thumbNail;
  final String routineName;
  final String duration;
  final String type;
  final String category;
  final QuillController workoutOverview;
  final bool isShowOptions;
  final Function callBack;

  const RoutineExploreItemWidget({super.key, required this.routId, required this.routineName, required this.duration, required this.callBack, required this.thumbNail, required this.type, required this.category, required this.workoutOverview, required this.isShowOptions});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
                child: Image.network(thumbNail, width: 100, height: 100, fit: BoxFit.cover,)
            ),
            const SizedBox(width: 6,),
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
                            SizedBox(width: MediaQuery.of(context).size.width - 190, child: Text(routineName, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),)),
                          ],
                        ),
                        if(!isShowOptions)
                          PopupMenuButton<SampleItem>(
                          color: Colors.white,
                          padding: EdgeInsets.only(right: 0),
                          onSelected: (SampleItem item) {

                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                            PopupMenuItem<SampleItem>(
                              padding: EdgeInsets.only(left: 20, right: 50),
                              value: SampleItem.Delete,
                              child: Text('Delete'),
                              onTap: (){
                                callBack("delete");
                              },
                            ),
                            PopupMenuItem<SampleItem>(
                              padding: EdgeInsets.only(left: 20, right: 50),
                              value: SampleItem.Duplicate,
                              child: Text('Duplicate'),
                              onTap: () {
                                callBack("duplicate");
                              },
                            ),
                            PopupMenuItem<SampleItem>(
                              padding: EdgeInsets.only(left: 20, right: 50),
                              value: SampleItem.Edit,
                              child: Text('Edit'),
                              onTap: () {
                                callBack("edit");
                              },
                            ),
                            const PopupMenuItem<SampleItem>(
                              padding: EdgeInsets.only(left: 20, right: 50),
                              value: SampleItem.Log,
                              child: Text('Log'),
                            ),
                            const PopupMenuItem<SampleItem>(
                              padding: EdgeInsets.only(left: 20, right: 50),
                              value: SampleItem.Share,
                              child: Text('Share'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 3,),
                    SizedBox(
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          checkBoxReadOnly: true,
                          controller: workoutOverview,
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