import 'package:do_an_2/model/planDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ManageTaskController extends GetxController{
  late PlanDTO planDTO;
  RxInt currentWeek = 0.obs;
  RxList selectedWeekDay = [].obs;
  RxList tasks = [].obs;

  @override
  void onInit() {
    planDTO = Get.arguments['item'];
    
    for(int i = 0; i < planDTO.duration!; i++){
      selectedWeekDay.value.add(0);
    }

    for(int i = 1; i <= planDTO.duration! * 7; i++){
      tasks.add(
          {
            "week": (i / 7).ceil(),
            "dayOfWeek": i % 8 == 0 ? 1 : i % 7,
            "taskDescription": TextEditingController(),
            "subTaskList": [].obs,
          }
      );
    }


  }

  String getWeekDay(int index){
    switch(index){
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thur';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      case 6:
        return 'Sun';
      default:
        return 'Unknown';
    }
  }
}