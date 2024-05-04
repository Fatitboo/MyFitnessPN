import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/res/widgets/tab_button.dart';
import 'package:do_an_2/views/user/application_user/application_controller.dart';
import 'package:do_an_2/views/user/diary/diary_page.dart';
import 'package:do_an_2/views/user/home/home_page.dart';
import 'package:do_an_2/views/user/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationUserPage extends GetView<ApplicationUserController> {
  ApplicationUserPage({super.key});
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
              const SizedBox(
                width: 40,
              ),
              TabButton(
                  icon: "assets/icons/camera_tab.png",
                  selectIcon: "assets/icons/camera_tab_select.png",
                  isActive: selectTab == 2,
                  onTap: () {
                    selectTab.value = 2;
                    controller.handleNavBarTap(2);
                  }),
              TabButton(
                  icon: "assets/icons/profile_tab.png",
                  selectIcon: "assets/icons/profile_tab_select.png",
                  isActive: selectTab == 3,
                  onTap: () {
                    selectTab.value = 3;
                    controller.handleNavBarTap(3);
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
        HomePage(),
        DiaryPage(),
        ProfilePage(),
        ProfilePage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigation(context),
      body: _buildPageView(),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColor.primaryG,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                  )
                ]),
            child: Icon(
              Icons.add,
              color: AppColor.white,
              size: 48,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
