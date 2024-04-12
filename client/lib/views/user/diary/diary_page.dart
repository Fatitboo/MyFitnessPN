import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../res/values/constants.dart';


class DiaryPage extends GetView<DiaryController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          Text('Diary page'),
          ElevatedButton(onPressed: () {
            Get.toNamed(AppRoutes.EXERCISE, arguments: {"type": Constant.EXERCISE_strength}, preventDuplicates: false);
          }, child: Text("Log Strength")),
          ElevatedButton(onPressed: () {
            Get.toNamed(AppRoutes.EXERCISE, arguments: {"type": Constant.EXERCISE_cardio}, preventDuplicates: false);
          }, child: Text("Log Cardio")),
          Center(
            child: Text('Diary page: '+ controller.str.value),

          ),
          ElevatedButton(onPressed: (){Get.toNamed(AppRoutes.FOOD_OVERVIEW);}, child: Text("Log food"))
        ],
      ),
    );
  }

}