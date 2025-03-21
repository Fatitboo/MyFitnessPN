import 'dart:convert';

import 'package:do_an_2/model/planDTO.dart';
import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/res/widgets/loading_widget.dart';
import 'package:do_an_2/views/admin/plan_management/plan/components/plan_item_widget.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_review/plan_review_page.dart';
import 'package:do_an_2/views/user/plan/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class PlanPage extends GetView<PlanAdminController>{
  const PlanPage(this.type, {super.key});
  final String type;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text("PLANS", style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black38,
            height: 1.0,
          ),
        )
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: LoadingWidget(loading: controller.loading.value)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 7),
              child: SizedBox(
                height: 35,
                child: ListView.builder(
                  itemCount: controller.planTypeList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext ct, int index){
                    return GestureDetector(
                      onTap: (){
                        controller.selectedPlanType.value = index;
                        controller.filterPlanType(controller.planTypeList.value[index].name.toString());
                        controller.planTypeList.refresh();
                        },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(18)),
                          border: index != controller.selectedPlanType.value ? Border.all(color: Colors.black87, width: 1) : Border.all(width: 0),
                          color: index != controller.selectedPlanType.value ? AppColor.white : AppColor.OutlineButtonColor
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                          child: Center(child: Text(controller.planTypeList.value[index].name.toString(), style: TextStyle(color: index != controller.selectedPlanType.value ? Colors.black : Colors.white),)),
                        ),
                      )
                    );
                  }
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: controller.myPlanList.length,
                  itemBuilder: (BuildContext ct, int index) {
                    PlanDTO planDTO = controller.myPlanList.value.elementAt(index);
                    QuillController quill = QuillController.basic();
                    quill.document = Document.fromJson(jsonDecode(planDTO.overview.toString()));
                    return GestureDetector(
                      onTapDown: (position){
                        final RenderBox renderBox = context.findRenderObject() as RenderBox;
                        controller.tapPosition.value = renderBox.globalToLocal(position.globalPosition);
                        Get.to(PlanReviewPage(planDTO: planDTO, type: type, planController: PlanController(),));
                      },

                      child: PlanItemAdminWidget(
                        planType: planDTO.planType ?? '',
                        thumbnail: planDTO.thumbnail ?? '',
                        title: planDTO.title ?? '',
                        duration: planDTO.duration ?? 0, // number of week
                        timePerWeek: planDTO.timePerWeek ?? 0,
                        overview: quill,
                        difficulty: planDTO.difficulty ?? '',
                        isFuncs: type == "admin",
                        callBack: (type) {
                          switch(type){
                            case "manage-task":
                              Get.toNamed(AppRoutes.PLAN_TASK_MANAGEMENT, arguments: {"item": planDTO});
                              break;
                            case "edit":
                              // Get.toNamed(AppRoutes.PLAN_MANAGEMENT_ADD, arguments: {"type": "edit"})?.then(
                              //         (value) => {
                              //       // controller.resetValue()
                              //     }
                              // );
                              break;
                            case "duplicate":
                              // controller.createRoutine(jsonEncode( routineDTO.toJson(routineDTO)));
                          }
                        },
      
                      ),
                    );
                  }
              ),
            ),
            if(type == "admin")
              Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                width: 1,
                                color: AppColor.OutlineButtonColor
                            )
                        ),
                        onPressed: () async{
                          controller.planTypes = controller.planTypeList.map((element) => element.name.toString()).toList();
                          if(controller.planTypes.isNotEmpty){
                            controller.selectedType.value = controller.planTypes[0];
                          }
                          Get.toNamed(AppRoutes.PLAN_MANAGEMENT_ADD, arguments: {"type": "add"})?.then(
                              (value) => {
                                // controller.resetValue()
                              }
                          );
                        },
                        child: Text("Create Plan", style: TextStyle(fontSize: 16, color: AppColor.OutlineButtonColor),)
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}