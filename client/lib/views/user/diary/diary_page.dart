import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DiaryPage extends GetView<DiaryController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {
      return Column(
        children: [
          Center(
            child: Text('Diary page: '+ controller.str.value),

          ),
          ElevatedButton(onPressed: (){controller.getFoodSaved();}, child: Text("dddd"))
        ],
      );
    });
  }

}