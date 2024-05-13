
import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class ApplicationUserController extends GetxController {
  ApplicationUserController();
  var page = 0.obs;
  late final PageController pageController;

  void handleChangePage(int index){
    page.value = index;
  }
  void handleNavBarTap(int index){
    if(index==1 || index == 0){
      DiaryController diaryController = Get.find<DiaryController>();
      diaryController.getLogDiaryByDateFoodSaved(DateTime.now());

    }
    if(index==0){
      HomeController homeController = Get.find<HomeController>();
      homeController.percent.value = (homeController.getLogInfor()["food"]!/ homeController.userHealthDTO.value.getCaloriesNeed())*100;

    }
    pageController.jumpToPage(index);

  }
  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: page.value, keepPage: false);

  }

}