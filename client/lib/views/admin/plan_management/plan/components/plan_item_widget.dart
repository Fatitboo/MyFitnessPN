import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';


enum SampleItem { Delete, Duplicate, Edit, Log, Share}

class PlanItemAdminWidget extends StatelessWidget{

  final String planType;
  final String thumbnail;
  final String title;
  final int duration; // number of week
  final int timePerWeek;
  final QuillController overview;
  final String difficulty;
  final bool isFuncs;
  final Function callBack;

  const PlanItemAdminWidget({super.key, required this.planType, required this.thumbnail, required this.title, required this.duration, required this.timePerWeek, required this.overview, required this.difficulty, required this.isFuncs, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        height: 230,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
                  child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Image.network(thumbnail, height: 150, fit: BoxFit.fitWidth,)),
                  ],
                )
            ),
            const SizedBox(width: 6,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery.of(context).size.width - 90,
                            child: Text(title, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),)
                          ),
                          if(isFuncs)
                            PopupMenuButton<SampleItem>(
                              color: Colors.white,
                              padding: const EdgeInsets.only(right: 0),
                              onSelected: (SampleItem item) {

                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                                PopupMenuItem<SampleItem>(
                                  padding: const EdgeInsets.only(left: 20, right: 50),
                                  value: SampleItem.Edit,
                                  child: const Text('Manage Tasks'),
                                  onTap: () {
                                    callBack("manage-task");
                                  },
                                ),
                                PopupMenuItem<SampleItem>(
                                  padding: const EdgeInsets.only(left: 20, right: 50),
                                  value: SampleItem.Edit,
                                  child: const Text('Edit'),
                                  onTap: () {
                                    callBack("edit");
                                  },
                                ),
                                PopupMenuItem<SampleItem>(
                                  padding: const EdgeInsets.only(left: 20, right: 50),
                                  value: SampleItem.Delete,
                                  child: const Text('Delete'),
                                  onTap: (){
                                    callBack("delete");
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${duration * 7} days"),
                                  Container(height: 5, width: 5, decoration: const BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.all(Radius.circular(5))), margin: EdgeInsets.only(left: 5, right: 5),),
                                  SizedBox(width: 100,child: Text(timePerWeek == 7 ? 'Daily' : '${timePerWeek}x a week', overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ]
                ),
              ),
            ),
          ],
        )
    );
  }
}