import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:do_an_2/views/admin/plan_management/plan/manage_task/manage_task_controller.dart';
import 'package:do_an_2/views/common_widgets/routine_explore_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubTaskItem extends GetView<ManageTaskController> {
  const SubTaskItem({required this.taskIndex,required this.subTaskIndex, super.key});
  final int taskIndex;
  final int subTaskIndex;

  String capitalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    var subTask = controller.tasks.value[taskIndex]['subTaskList'][subTaskIndex];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Task type: ${capitalize(subTask['subTaskType'])}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),),
              GestureDetector(
                onTap: (){
                  controller.removeSubTaskOutTask(taskIndex, subTaskIndex);
                  controller.tasks.refresh();
                },
                child: const Icon(
                  Icons.close,
                  size: 22,
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 50,
            child: TextField(
              controller: subTask['subTaskName'],
              decoration: const InputDecoration(
                  hintText: "Task name",
                  // errorText: controller.errors["title"]!.isError ? controller.errors["title"]!.message : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )
              ),
              keyboardType: TextInputType.multiline,
            ),
          ),
          const SizedBox(height: 5,),
          if(subTask['subTaskType'] == Constant.SUBTASK_normal)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: subTask['subTaskDescription'],
                maxLines: 3,
                decoration: const InputDecoration(
                    hintText: "Task description",
                    // errorText: controller.errors["title"]!.isError ? controller.errors["title"]!.message : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )
                ),
                keyboardType: TextInputType.multiline,
              ),
            )
          else if(subTask['subTaskType'] == Constant.SUBTASK_link)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 50,
                  child: TextField(
                    controller: subTask['subTaskLink'],
                    decoration: const InputDecoration(
                        hintText: "Linked",
                        // errorText: controller.errors["title"]!.isError ? controller.errors["title"]!.message : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: subTask['subTaskDescription'],
                    maxLines: 3,
                    decoration: const InputDecoration(
                        hintText: "Task description",
                        // errorText: controller.errors["title"]!.isError ? controller.errors["title"]!.message : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ],
            )
          else if(subTask['subTaskType'] == Constant.SUBTASK_workout)
            subTask['routine'] == null ?
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.ADMIN_ROUTINE_PAGE, arguments: {'from': 'sub-task'})?.then((value) => {
                  subTask['routine'] = value,
                  controller.tasks.refresh()
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.OutlineButtonColor.withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                child: const Center(
                  child: Text(
                    "Select workout",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ): Stack(
              children: [
                RoutineExploreItemTaskWidget(
                  routineName: subTask['routine'].routineName ?? "",
                  duration: subTask['routine'].duration.toString(),
                  type: subTask['routine'].type.toString(),
                  category: subTask['routine'].category.toString(),
                  workoutOverview: subTask['routine'].workoutOverview,
                  callBack: () {},
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.ADMIN_ROUTINE_PAGE, arguments: {'from': 'sub-task'})?.then((value) => {
                          subTask['routine'] = value,
                          controller.tasks.refresh()
                        });
                      },
                      child: const Icon(
                        Icons.autorenew_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

}