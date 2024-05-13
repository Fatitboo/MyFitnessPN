import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/admin/plan_management/plan/manage_task/manage_task_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class ManageTaskPage extends GetView<ManageTaskController>{
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(controller.planDTO.title!),
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
                                  itemWeekScrollController.scrollTo(index: id, duration: const Duration(milliseconds: 500));
                                  controller.selectedWeekDay.value[index] = id;
                                  controller.selectedWeekDay.refresh();
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  width: MediaQuery.of(context).size.width / 7 - 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    border: Border.all(width: 1, color: Colors.black87),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.selectedWeekDay.value[index] != id ? Colors.grey.withOpacity(0.5) : AppColor.OutlineButtonColor.withOpacity(0.9),
                                          spreadRadius: 0,
                                          blurRadius: 5,
                                          offset: const Offset(0, 2), // changes position of shadow
                                        ),
                                      ],
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Center(child: Text(controller.getWeekDay(id), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),)),
                                ),
                              );
                            },
                          )
                        ),
                        SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ScrollablePositionedList.builder(
                            itemScrollController: itemWeekScrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 7,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, indexPage) {
                              return Column(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      child: Center(child: Text("Thứ ${indexPage + 1}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),))),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: TextField(
                                      controller: controller.tasks.value[(indexPage + 1) * (index + 1) - 1]['taskDescription'],
                                      decoration: InputDecoration(
                                          hintText: "Task descriptions",
                                          // errorText: controller.errors["title"]!.isError ? controller.errors["title"]!.message : null,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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
