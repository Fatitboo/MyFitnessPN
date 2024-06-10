import 'dart:ui';

import 'package:do_an_2/model/components/subTask.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:do_an_2/views/user/plan/webview/web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../plan_controller.dart';

class SubTaskItem extends GetView<PlanController> {
  SubTaskItem(this.subTask, this.toggle, {super.key});
  final SubTask subTask;
  final VoidCallback toggle;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 50,
          child: Checkbox(value: subTask.isFinish, onChanged: (bool? value) {
            if(value != null){
              toggle();
            }
          },),
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Column(
            children: [
              Opacity(
                opacity: subTask.isFinish! ? 0.5 : 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(subTask.subTaskType == Constant.SUBTASK_link){
                          Get.to(Webview(subTask.subTaskLink ?? ""));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 110,
                              child: Text(subTask.subTaskName!, overflow: TextOverflow.clip, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, decoration: subTask.isFinish! ? TextDecoration.lineThrough: TextDecoration.none),)),
                          if(subTask.subTaskType == Constant.SUBTASK_link)
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            )
                        ],
                      ),
                    ),
                    Text(subTask.subTaskDescription!, overflow: TextOverflow.clip),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black38,
                ),
              )
            ],
          ),
        ),

      ],
    );
  }

}