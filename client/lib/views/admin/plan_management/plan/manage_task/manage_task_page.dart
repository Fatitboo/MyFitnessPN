import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:do_an_2/res/widgets/loading_widget.dart';
import 'package:do_an_2/views/admin/plan_management/plan/manage_task/manage_task_controller.dart';
import 'package:do_an_2/views/admin/plan_management/plan/manage_task/sub-task/sub_task_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

enum SampleItem { Delete, Duplicate, Edit, Log, Share}

class ManageTaskPage extends GetView<ManageTaskController>{
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Stack(
              children: [
                Align(alignment: Alignment.centerLeft, child: Text(controller.planDTO.title!)),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      if(await controller.saveTasks(context)){
                        Get.back();
                      }
                      else{
                        print(" tasupdatek failed");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor1,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: controller.loading.value ? LoadingWidget(loading: controller.loading.value) : const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.8),
              child: Container(
                color: Colors.black54,
                height: 0.8,
              ),
            )
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.planDTO.duration!,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    ItemScrollController itemWeekScrollController = ItemScrollController();
                    return Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: Center(child: Text("Week ${index + 1}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),))),
                        const SizedBox(height: 12,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (BuildContext ct, int id){
                              return GestureDetector(
                                onTap: (){
                                  if(controller.isHideRestDaysOfWeek.value[index]){
                                    if(!controller.currentDaysOfWeek.value[index * 7 + id]){
                                      return;
                                    }
                                  }

                                  itemWeekScrollController.scrollTo(index: id, duration: const Duration(milliseconds: 500));
                                  controller.selectedWeekDay.value[index] = id;
                                  controller.loadWorkoutInfo(index * 7 + id);
                                  controller.selectedWeekDay.refresh();
                                },
                                child: Opacity(
                                  opacity:
                                    controller.isHideRestDaysOfWeek.value[index]
                                      ? controller.currentDaysOfWeek.value[index * 7 + id]
                                        ? 1
                                        : 0.5
                                      : 1,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    width: MediaQuery.of(context).size.width / 7 - 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      border: Border.all(width: 1, color: Colors.black87),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                controller.selectedWeekDay.value[index] != id
                                                  ? Colors.grey.withOpacity(0.5)
                                                  : AppColor.OutlineButtonColor.withOpacity(0.9),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2), // changes position of shadow
                                          ),
                                        ],
                                      borderRadius: const BorderRadius.all(Radius.circular(5))
                                    ),
                                    child: Center(child: Text(controller.getWeekDay(id), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),)),
                                  ),
                                ),
                              );
                            },
                          )
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ScrollablePositionedList.builder(
                              itemScrollController: itemWeekScrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, indexPage) {
                                return Column(
                                  children: [
                                  const SizedBox(height: 15,),
                                  SizedBox(width: MediaQuery.of(context).size.width,child: const Text("Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                  const SizedBox(height: 5,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                    width: MediaQuery.of(context).size.width - 10,
                                    child: TextField(
                                      controller: controller.tasks.value[index * 7 + indexPage]['taskDescription'],
                                      decoration: const InputDecoration(
                                          hintText: "Ex: Set achievable goals and learn ...",
                                          // errorText: controller.errors["title"]!.isError ? controller.errors["title"]!.message : null,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          )
                                      ),
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  SizedBox(width: MediaQuery.of(context).size.width - 10,
                                      child: Row(
                                        children: [
                                          const Expanded(child: Text("Task List", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                          GestureDetector(
                                            child: PopupMenuButton<SampleItem>(
                                              color: Colors.white,
                                              padding: const EdgeInsets.only(right: 0),
                                              icon: const Icon(
                                                Icons.add,
                                                size: 22,
                                              ),
                                              itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                                                PopupMenuItem<SampleItem>(
                                                  padding: const EdgeInsets.only(left: 20, right: 50),
                                                  value: SampleItem.Delete,
                                                  child: const Text('Normal'),
                                                  onTap: (){
                                                    controller.addSubTaskToTask(index * 7 + indexPage, Constant.SUBTASK_normal);
                                                    controller.tasks.refresh();
                                                  },
                                                ),
                                                PopupMenuItem<SampleItem>(
                                                  padding: const EdgeInsets.only(left: 20, right: 50),
                                                  value: SampleItem.Edit,
                                                  child: const Text('Workout'),
                                                  onTap: () {
                                                    controller.addSubTaskToTask(index * 7 + indexPage, Constant.SUBTASK_workout);
                                                    controller.tasks.refresh();
                                                  },
                                                ),
                                                PopupMenuItem<SampleItem>(
                                                  padding: const EdgeInsets.only(left: 20, right: 50),
                                                  value: SampleItem.Edit,
                                                  child: const Text('Link'),
                                                  onTap: () {
                                                    controller.addSubTaskToTask(index * 7 + indexPage, Constant.SUBTASK_link);
                                                    controller.tasks.refresh();
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: MediaQuery.sizeOf(context).width,
                                      child: ListView.builder(
                                          itemCount: controller.tasks.value[index * 7 + indexPage]['subTaskList'].length,
                                          itemBuilder: (BuildContext context, int indexSubTask){
                                            return SubTaskItem(taskIndex: index * 7 + indexPage, subTaskIndex: indexSubTask);
                                          }
                                      ),
                                    ),
                                  )
                                ]
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.white.withOpacity(0.8),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        size: 24,
                      ),
                    ),
                    onTap: (){
                      if(controller.currentWeek.value > 0){
                        controller.currentWeek.value = controller.currentWeek.value - 1;
                        controller.checkFullDaysOfWeek(controller.currentWeek.value);
                        controller.isHideRestDaysOfWeek.refresh();
                      }
                      _scrollController.scrollTo(index: controller.currentWeek.value, duration: const Duration(milliseconds: 500));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.white.withOpacity(0.8),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        size: 24,
                      ),
                    ),
                    onTap: (){
                      if(controller.currentWeek.value < controller.planDTO.duration! - 1){
                        controller.currentWeek.value = controller.currentWeek.value + 1;
                        controller.checkFullDaysOfWeek(controller.currentWeek.value);
                        controller.isHideRestDaysOfWeek.refresh();
                      }
                      _scrollController.scrollTo(index: controller.currentWeek.value, duration: const Duration(milliseconds: 500));
                    },
                  ),
                ],
              ),
            ],
          )
      )
    ));
  }
}
