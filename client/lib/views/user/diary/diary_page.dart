import 'package:do_an_2/res/values/constants.dart';
import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../res/routes/names.dart';

class DiaryPage extends GetView<DiaryController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          Text('Diary page'),
          ElevatedButton(onPressed: () {
            Get.toNamed(AppRoutes.EXERCISE, arguments: {"type": Constant.EXERCISE_strength, "from": "diary"}, preventDuplicates: false);
          }, child: Text("Log Strength")),
          ElevatedButton(onPressed: () {
            Get.toNamed(AppRoutes.EXERCISE, arguments: {"type": Constant.EXERCISE_cardio, "from": "diary"}, preventDuplicates: false);
          }, child: Text("Log Cardio")),
          ElevatedButton(onPressed: () {
            Get.toNamed(AppRoutes.ROUTINE);
          }, child: Text("Log Routine"))
        ],
      ),
    );
  }

}