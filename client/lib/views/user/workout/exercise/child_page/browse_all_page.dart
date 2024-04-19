import 'package:do_an_2/views/user/workout/exercise/exercise_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/exerciseDTO.dart';
import '../../../../../res/values/constants.dart';
import '../../../../../res/widgets/loading_widget.dart';

class BrowseAllPage extends GetView<ExerciseController> {


  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: LoadingWidget(loading: controller.loading.value)),
          Expanded(
            child: ListView.builder(
                itemCount: controller.browserList.length,
                itemBuilder: (BuildContext context, int index) {
                  ExerciseDTO exerciseDTO = controller.browserList.value.elementAt(index);
                  return GestureDetector(
                      onTap: () {
                        if(controller.from.value == "routine"){
                          Get.back(result: controller.browserList[index].name);
                        }
                      },
                      child:Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(exerciseDTO.name!, style: const TextStyle(fontSize: 16),),
                                exerciseDTO.type == Constant.EXERCISE_strength.toLowerCase() ?
                                Text(exerciseDTO.getStringStrengthValues(), style: const TextStyle(color: Colors.black54),)
                                    :
                                Text(exerciseDTO.getStringCardioValues(), style: const TextStyle(color: Colors.black54),)
                              ],
                            ),
                          ],
                        ),
                      ),
                  );
                }
            ),
          ),
        ],
      ),
    ));
  }
}