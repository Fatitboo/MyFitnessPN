import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/admin/plan_management/plan/create_plan/first_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/create_plan/fourth_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/create_plan/review_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/create_plan/second_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/create_plan/third_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../common_widgets/keep_alive_page.dart';

class AddPlanAdminPage extends StatefulWidget {
  const AddPlanAdminPage({super.key});

  @override
  State<AddPlanAdminPage> createState() => AddPlanAdminPageState();
}

class AddPlanAdminPageState extends State<AddPlanAdminPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(alignment: Alignment.topCenter, children: [
              _buildPageView(),
              _buildDotIndicator(),
            ]),
          )),
    );
  }
}

class _buildDotIndicator extends GetView<PlanManagementController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() => Positioned(
        top: 40,
        width: 200.w,
        height: 10.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 10,
            child: LinearPercentIndicator(
              lineHeight: 6.h,
              backgroundColor: AppColor.primaryColor3,
              progressColor: AppColor.primaryColor1,
              percent: controller.progressValue.value,
              animateFromLastPercent: true,
              barRadius: const Radius.circular(3),
              animation: true,
              restartAnimation: false,
            ),
          ),
        )));
  }
}

class _buildPageView extends GetView<PlanManagementController> {
  final PageController pageController =
  PageController(initialPage: 0, keepPage: false, viewportFraction: 1);
  int currentPageIndex = 0;
  movingNextPage(PageController pageController, int currentPageIndex) {
    print(currentPageIndex);
    if (pageController.hasClients) {
      pageController.animateToPage(
        currentPageIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  movingPreviousPage(PageController pageController, int currentPageIndex) {
    print(currentPageIndex);
    if (currentPageIndex > 0) {
      pageController.animateToPage(
        currentPageIndex - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: PageView(
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          controller.changePage(index);
        },
        controller: pageController,
        pageSnapping: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FirstPage(onTap: () {
            currentPageIndex = pageController.page!.round();
            movingNextPage(pageController, currentPageIndex);
          },),
          KeepAlivePage(
            child: SecondPage(onTap: () {
              currentPageIndex = pageController.page!.round();
              movingNextPage(pageController, currentPageIndex);
            }, back: () {
              currentPageIndex = pageController.page!.round();
              movingPreviousPage(pageController, currentPageIndex);
            })),
          KeepAlivePage(
              child: ThirdPage(onTap: () {
                currentPageIndex = pageController.page!.round();
                movingNextPage(pageController, currentPageIndex);
              }, back: () {
                currentPageIndex = pageController.page!.round();
                movingPreviousPage(pageController, currentPageIndex);
              })),
          KeepAlivePage(
              child: FourthPage(onTap: () {
                currentPageIndex = pageController.page!.round();
                movingNextPage(pageController, currentPageIndex);
                }, back: () {
                currentPageIndex = pageController.page!.round();
                movingPreviousPage(pageController, currentPageIndex);
              })),
          KeepAlivePage(
              child: ReviewPage(onTap: () {
                print("call api");
              }, back: () {
                currentPageIndex = pageController.page!.round();
                movingPreviousPage(pageController, currentPageIndex);
              }))
        ],
      ),
    );
  }
}
