import 'package:do_an_2/views/admin/plan_management/plan-type/plan_type_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/add_plan_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PlanManagementPage extends GetView<PlanManagementController> {

  final List<Widget> _tabs = [
    PlanPage("admin"),
    PlanTypePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Plan Management"),
          bottom: TabBar(
            onTap: (index){
              switch(index){
                case 0:
                  controller.getAllPlanTypes();
                  Get.find<PlanAdminController>().planTypeList.value = controller.listPlanTypes.value;
                  Get.find<PlanAdminController>().selectedPlanType.value = -1;
                  Get.find<PlanAdminController>().getAllPlans();
                  break;
                case 1:
                  controller.getAllPlanTypes();
                  break;
              }
            },
            tabs: const [
              SizedBox(
                width: double.maxFinite,
                child: Tab(text: 'PLAN'),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Tab(text: 'PLAN TYPE'),
              ),
            ],
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TabBarView(
                  children: _tabs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
