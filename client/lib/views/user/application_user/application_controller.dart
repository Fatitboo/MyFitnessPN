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
    pageController.jumpToPage(index);
  }
  @override
  void onInit() {
    pageController = PageController(initialPage: page.value, keepPage: false);
    super.onInit();
  }
}