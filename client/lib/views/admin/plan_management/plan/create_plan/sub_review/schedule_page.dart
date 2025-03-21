import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class SchedulePage extends GetView<PlanAdminController>{
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      margin: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.weekDescriptions.value.length,
            itemBuilder: (BuildContext ct, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  Text("Week ${index + 1}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                  const SizedBox(height: 5,),
                  Text(controller.weekDescriptions.value.elementAt(index).text, style: const TextStyle(fontSize: 16),),
                ],
              );
            },
          ),
          Container(height: 80,)
        ],
      ),
    ));
  }
}