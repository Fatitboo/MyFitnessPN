import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/res/widgets/tab_button.dart';
import 'package:do_an_2/views/admin/application_admin/application_controller.dart';
import 'package:do_an_2/views/admin/blog_management/blog_management_page.dart';
import 'package:do_an_2/views/admin/meal_management/meal_management_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan_management_page.dart';
import 'package:do_an_2/views/admin/profile_admin/profile_admin_page.dart';
import 'package:do_an_2/views/admin/workout_management/workout_management_page.dart';
import 'package:do_an_2/views/user/application_user/application_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationAdminPage extends GetView<ApplicationAdminController> {
  ApplicationAdminPage({super.key});
  var selectTab = 0.obs;

  Widget _buildBottomNavigation(BuildContext c) {
    Get.put(ApplicationUserController());
    return Obx(() => BottomAppBar(
        color: AppColor.white,
        surfaceTintColor: AppColor.white,
        elevation: 20,
        shadowColor: AppColor.gray,
        child: Container(
          color: AppColor.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                  icon: "assets/icons/dashboard.png",
                  selectIcon: "assets/icons/home_tab_select.png",
                  isActive: selectTab == 0,
                  onTap: () {
                    selectTab.value = 0;
                    controller.handleNavBarTap(0);
                  }),
              TabButton(
                  icon: "assets/icons/diary.png",
                  selectIcon: "assets/icons/activity_tab_select.png",
                  isActive: selectTab == 1,
                  onTap: () {
                    selectTab.value = 1;
                    controller.handleNavBarTap(1);
                  }),

              TabButton(
                  icon: "assets/icons/meal.png",
                  selectIcon: "assets/icons/meal_select.png",
                  isActive: selectTab == 2,
                  onTap: () {
                    selectTab.value = 2;
                    controller.handleNavBarTap(2);
                  }),
              TabButton(
                  icon: "assets/icons/workout.png",
                  selectIcon: "assets/icons/workout_select.png",
                  isActive: selectTab == 3,
                  onTap: () {
                    selectTab.value = 3;
                    controller.handleNavBarTap(3);
                  }),
              TabButton(
                  icon: "assets/icons/profile_tab.png",
                  selectIcon: "assets/icons/profile_tab_select.png",
                  isActive: selectTab == 4,
                  onTap: () {
                    selectTab.value = 4;
                    controller.handleNavBarTap(4);
                  })
            ],
          ),
        )));
  }

  Widget _buildPageView() {
    return PageView(
      reverse: false,
      controller: controller.pageController,
      onPageChanged: (index) => {controller.handleChangePage(index)},
      physics: const NeverScrollableScrollPhysics(),
      children: [
        BlogManagementPage(),
        PlanManagementPage(),
        MealManagementPage(),
        WorkoutManagementPage(),
        ProfileAdminPage()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigation(context),
      body: _buildPageView(),


    );
  }
}
