import 'dart:convert';
import 'dart:developer';
import 'package:do_an_2/data/network/cloudinary.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:do_an_2/views/admin/plan_management/plan/create_plan/sub_review/overview_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/create_plan/sub_review/schedule_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/create_plan/success_create_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/my_button.dart';
import "dart:core";

class ReviewPage extends GetView<PlanAdminController>{
  final VoidCallback back;
  final VoidCallback onTap;
  ReviewPage({super.key,  required this.onTap, required this.back});
  final List<Widget> _tabs = [
    OverviewPage(),
    SchedulePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
      length: _tabs.length,
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
                            controller.thumbnail.value.path != '' ?
                            Image.file(controller.thumbnail.value, height: 200, fit: BoxFit.cover,)
                                : Container(height: 200, decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54, width: 1)
                            )
                            )
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(controller.textEditController.value["title"]!.text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
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
                        children: _tabs,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: MyButton(
                            onTap: () {
                              back();
                            },
                            bgColor: AppColor.white,
                            textString: 'Back',
                            textColor: AppColor.blackText,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            children: [
                              MyButton(
                                onTap: () async{
                                  Map<String, dynamic> resThumbnail = await CloudinaryNetWork().upload(Constant.CLOUDINARY_ADMIN_PLAN_IMAGE, controller.thumbnail.value!, Constant.FILE_TYPE_image);
                                  if(resThumbnail["isSuccess"]){
                                    var obj = {
                                      "title": controller.textEditController.value["title"]!.text,
                                      "planType": controller.selectedType.value,
                                      "thumbnail": resThumbnail["imageUrl"],
                                      "duration": int.parse(controller.textEditController.value["duration"]!.text),
                                      "timePerWeek": controller.selectedTimePerWeek.value,
                                      "overview": jsonEncode(controller.overviewController.document.toDelta().toJson()),
                                      "difficulty": controller.selectedDifficulty.value,
                                      "descriptions": controller.convertDescription(),
                                      "weekDescription": controller.weekDescriptions.value.map((element) => element.text.toString()).toList()
                                    };
                                    log('$obj');
                                    if(await controller.createPlan(jsonEncode(obj))){
                                      Get.to(SuccessCreatePage())?.then((value) => {
                                        Get.back()
                                      });
                                    }
                                  }
                                  else{
                                    print(resThumbnail["message"]);
                                  }
                                },
                                bgColor: AppColor.blackText,
                                textString: 'Create',
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
    ));
  }
}