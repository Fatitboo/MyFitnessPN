import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/common_widgets/keep_alive_page.dart';
import 'package:do_an_2/views/user/welcome/pages/fifth_page.dart';
import 'package:do_an_2/views/user/welcome/pages/final_page.dart';
import 'package:do_an_2/views/user/welcome/pages/first_page.dart';
import 'package:do_an_2/views/user/welcome/pages/fourth_page.dart';
import 'package:do_an_2/views/user/welcome/pages/second_page.dart';
import 'package:do_an_2/views/user/welcome/pages/six_page.dart';
import 'package:do_an_2/views/user/welcome/pages/third_page.dart';
import 'package:do_an_2/views/user/welcome/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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

class _buildDotIndicator extends GetView<WelcomeController> {
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

class _buildPageView extends GetView<WelcomeController> {
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
      padding: const EdgeInsets.only(top: 150),
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
              child: FourthWelcomePage(onTap: () {
                currentPageIndex = pageController.page!.round();
                movingNextPage(pageController, currentPageIndex);
              }, back: () {
                currentPageIndex = pageController.page!.round();
                movingPreviousPage(pageController, currentPageIndex);
              })),
          KeepAlivePage(
              child: FifthWelcomePage(onTap: () {
                currentPageIndex = pageController.page!.round();
                movingNextPage(pageController, currentPageIndex);
              }, back: () {
                currentPageIndex = pageController.page!.round();
                movingPreviousPage(pageController, currentPageIndex);
              })),
          KeepAlivePage(
              child: SixWelcomePage(onTap: () {
                currentPageIndex = pageController.page!.round();
                movingNextPage(pageController, currentPageIndex);
              }, back: () {
                currentPageIndex = pageController.page!.round();
                movingPreviousPage(pageController, currentPageIndex);
              })),
          KeepAlivePage(
              child: FinalPage(onTap: () {
            controller.toPageApplication();
          }, back: () {
            currentPageIndex = pageController.page!.round();
            movingPreviousPage(pageController, currentPageIndex);
          }))
        ],
      ),


    );
  }
}
