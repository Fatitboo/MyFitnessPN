import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/routes/names.dart';

enum SampleItem { Delete, Duplicate, Edit, Log, Share}

class RoutineItemWidget extends StatelessWidget{

  final String routId;
  final String routineName;
  final String description;
  final String plannedVolume;
  final String duration;
  final String caloriesBurned;
  final List<ExerciseDTO> exercises;
  final Function callBack;

  const RoutineItemWidget({super.key, required this.routId, required this.routineName, required this.description, required this.plannedVolume, required this.duration, required this.caloriesBurned, required this.exercises, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      padding: const EdgeInsets.only(left: 15, right: 0, bottom: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(routineName, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),),
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
            ]
          ),
          const SizedBox(height: 3,),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Align(alignment: Alignment.centerLeft,child: Text(description, style: TextStyle(color: Color(0xff707070)),)),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(plannedVolume, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                    const Text("Plan Volume", style: TextStyle(color: Color(0xff707070)),)
                  ]
                ),
                Container(
                  width: 1,
                  height: 35,
                  color: Colors.grey,
                ),
                Column(
                    children: [
                      Text(duration, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                      const Text("Est. Duration", style: TextStyle(color: Color(0xff707070)),)
                    ]
                ),
                Container(
                  width: 1,
                  height: 35,
                  color: Colors.grey,
                ),
                Column(
                    children: [
                      Text(caloriesBurned, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                      const Text("Est. Calories", style: TextStyle(color: Color(0xff707070)),)
                    ]
                ),
              ],
            ),
          )
        ]
      )
    );
  }
}