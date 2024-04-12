import 'package:do_an_2/views/user/workout/exercise/exercise_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BrowseAllPage extends GetView<ExerciseController> {


  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        ListView.builder(
            itemCount: controller.browserList.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(controller.browserList.elementAt(index)["name"].toString());
            }
        ),
      ],
    ));
  }
}