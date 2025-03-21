import 'package:do_an_2/model/planDTO.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_review/sub_review/overview_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_review/sub_review/schedule_page.dart';
import 'package:do_an_2/views/user/application_user/application_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../res/values/color_extension.dart';
import '../../../../../../../res/widgets/my_button.dart';
import "dart:core";

import '../../../../user/plan/plan_controller.dart';

class PlanReviewPage extends StatelessWidget{
  final PlanDTO planDTO;
  final String type;
  final PlanController planController;
  PlanReviewPage({super.key, required this.planDTO, required this.type, required this.planController});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height + 90,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child:
                            planDTO.thumbnail != '' ?
                            Image.network(planDTO.thumbnail!, height: 200, fit: BoxFit.cover,)
                                : Container(height: 200, decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54, width: 1)
                            )
                            )
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(planDTO.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
                        )
                      ],
                    ),
                    const TabBar(
                      tabs: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Tab(text: 'OVERVIEW'),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Tab(text: 'SCHEDULE'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          OverviewPage(planDTO),
                          SchedulePage(planDTO),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, left: 20),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,

                ),
              ),
            ),
            if(type == "user")
              Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              MyButton(
                                onTap: (){
                                  Get.find<ApplicationUserController>().handleNavigateUser(planDTO);
                                  Get.back();
                                },
                                bgColor: AppColor.blackText,
                                textString: 'Start plan',
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}