import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/workout/routine/routine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:do_an_2/model/components/set.dart';
import 'package:flutter/widgets.dart';

import '../../../../validate/Validator.dart';
import '../../../../validate/error_type.dart';
enum SampleItem { Duplicate, Delete }

class AddExerciseItem extends StatefulWidget{
  const AddExerciseItem({super.key, required this.controller, required this.index});

  final int index;
  final RoutineController controller;

  @override
  State<AddExerciseItem> createState() => AddExerciseItemState();

}

class AddExerciseItemState extends State<AddExerciseItem> {
  late List<Map<String, TextEditingController>> items;
  late List<Map<String, Val>> errors;
  late List<Map<String, Map<String, String>>> validators;
  late TextEditingController instructionController;
  late TextEditingController nameController;

  @override
  void initState() {
    items = widget.controller.textEditExercise[widget.index]["sets"];
    instructionController = widget.controller.textEditExercise[widget.index]["instruction"];
    nameController = widget.controller.textEditExercise[widget.index]["name"];
    errors = widget.controller.errorExes[widget.index]["sets"];
    validators = widget.controller.validateExes[widget.index]["sets"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nameController.text,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
                ),
                PopupMenuButton<SampleItem>(
                  color: Colors.white,
                  padding: const EdgeInsets.only(right: 0),
                  onSelected: (SampleItem item) {

                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                      padding: EdgeInsets.only(left: 20, right: 50),
                      value: SampleItem.Duplicate,
                      child: Text('Duplicate'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      padding: EdgeInsets.only(left: 20, right: 50),
                      value: SampleItem.Delete,
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: TextField(
              controller: instructionController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: 'Add description or notes...',
                hintStyle: TextStyle(color: Colors.grey,),
              ),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext ct, int index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    children: [
                      Container(width: 15 ,child: Text("${index + 1}", style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),)),
                      const SizedBox(width: 15,),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          textAlign: TextAlign.right,
                          textAlignVertical: TextAlignVertical.center,
                          controller: items[index]["weight"],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            errorText: errors[index]["weight"]!.isError ? errors[index]["weight"]!.message : null,
                            hintText: "kg",
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10)
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          textAlign: TextAlign.right,
                          textAlignVertical: TextAlignVertical.center,
                          controller: items[index]["rep"],
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              hintText: "reps",
                              errorText: errors[index]["rep"]!.isError ? errors[index]["rep"]!.message : null,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10)
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 1,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                items.add({
                  "rep": TextEditingController(),
                  "weight": TextEditingController()
                });
                errors.add({
                  "rep": Val(false, ""),
                  "weight": Val(false, ""),
                });
                validators.add({
                  "weight": {
                    ERROR_TYPE.require: "Required",
                    ERROR_TYPE.number: "Type number!",
                  },
                  "rep": {
                    ERROR_TYPE.require: "Required",
                    ERROR_TYPE.number: "Type number!",
                  },
                });
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: Align(alignment: Alignment.centerLeft, child: Text("ADD SET",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColor.OutlineButtonColor),)),
            ),
          ),
        ],
      ),
    );
  }
}