import 'package:do_an_2/model/planDTO.dart';
import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:do_an_2/views/user/profile/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class ApplicationUserController extends GetxController {
  ApplicationUserController();
  var page = 0.obs;
  late final PageController pageController;
  RxBool isStartPlan = false.obs;
  late PlanDTO planDTO;
  void handleChangePage(int index){
    page.value = index;
  }

  void handleNavigateUser(PlanDTO plan){
    isStartPlan.value = true;
    planDTO = plan;
  }

  void handleNavBarTap(int index){
    if(index==1 || index == 0){
      DiaryController diaryController = Get.find<DiaryController>();
      diaryController.getLogDiaryByDateFoodSaved(DateTime.now());

    }
    if(index==0){
      HomeController homeController = Get.find<HomeController>();
      homeController.percent.value = (homeController.getLogInfor()["food"]!/ homeController.userHealthDTO.value.getCaloriesNeed()) *100;
      homeController.perWater.value = ((homeController.getLogInfor()["water"])??0) / (homeController.userHealthDTO.value.waterIntake ?? 1000);

    }
    if(index==3){
      Get.find<ProfileController>().getUserHealth();

    }
    pageController.jumpToPage(index);

  }
  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: page.value, keepPage: false);

  }

}