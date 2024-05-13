import 'package:do_an_2/model/planTypeDTO.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/res/widgets/loading_widget.dart';
import 'package:do_an_2/views/admin/plan_management/plan-type/plan_type_form.dart';
import 'package:do_an_2/views/admin/plan_management/plan_management_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PlanTypePage extends GetView<PlanManagementController>{
  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: LoadingWidget(loading: controller.loading.value)),
          Expanded(
            child: ListView.builder(
                itemCount: controller.listPlanTypes.length,
                itemBuilder: (BuildContext ct, int index) {
                  PlanTypeDTO planTypeDTO = controller.listPlanTypes.value.elementAt(index);
                  return GestureDetector(
                    onTapDown: (position){
                      final RenderBox renderBox = context.findRenderObject() as RenderBox;
                      controller.tapPosition.value = renderBox.globalToLocal(position.globalPosition);
                    },
                    onLongPress: () {
                      final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();
                      final result = showMenu(
                        context: ct,
                        color: Colors.white,
                        items: <PopupMenuEntry> [
                          PopupMenuItem(
                            onTap: () async{
                              controller.selectedPlanType.value = planTypeDTO;
                              await showDialog(
                                  context: context,
                                  builder: (context) => PlanTypeForm(context: context, typeForm: "edit", planManagementController: controller,)
                              );
                            },
                            child: const Text("Edit"),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              controller.selectedPlanType.value = planTypeDTO;
                              controller.deletePlanType(planTypeDTO.planTypeId!, index);
                            },
                            child: const Text("Delete"),
                          )

                        ],
                        position: RelativeRect.fromRect(
                          Rect.fromLTWH(controller.tapPosition.value.dx, controller.tapPosition.value.dy, 10, 10),
                          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width, overlay!.paintBounds.size.height),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(planTypeDTO.name!, style: const TextStyle(fontSize: 16),),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                child: Text(maxLines: 3,planTypeDTO.description!, style: const TextStyle(color: Colors.black54),))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
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
                        await showDialog(
                          context: context,
                          builder: (context) => PlanTypeForm(context: context, typeForm: "add", planManagementController: controller,)
                        );
                      },
                      child: Text("Create Plan Type", style: TextStyle(fontSize: 16, color: AppColor.OutlineButtonColor),)
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }


}