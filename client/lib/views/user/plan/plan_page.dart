import 'package:do_an_2/model/components/subTask.dart';
import 'package:do_an_2/model/planDTO.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_page.dart';
import 'package:do_an_2/views/user/plan/sub_task/sub_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../res/widgets/loading_widget.dart';

class PlanObserveUserPage extends StatefulWidget {
  PlanObserveUserPage(this.planDTO, {super.key});
  final PlanDTO planDTO;

  @override
  State<PlanObserveUserPage> createState() => _PlanObserveUserPageState();
}

class _PlanObserveUserPageState extends State<PlanObserveUserPage> {
  final ItemScrollController _scrollController = ItemScrollController();
  bool loading = false;
  DateTime currentDate = DateTime.now();
  late PlanDTO planDTO;
  @override
  void initState() {
    planDTO = widget.planDTO;
  }
  int currentDay = 0;
  List<String> weekDays = [
    "", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];

  List<String> months = [
    "", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  void changeCurrentDate(int type) async{
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      if(type > 0) {
        currentDate = currentDate.add(const Duration(hours: 24));
      }
      else{
        if(type < 0){
          currentDate = currentDate.subtract(const Duration(hours: 24));
        }
      }
    });
  }
  void toggleSubTask(int indexTask, int indexSubTask){
    setState(() {
      planDTO.taskList![indexTask].subTaskList![indexSubTask].isFinish = !planDTO.taskList![indexTask].subTaskList![indexSubTask].isFinish!;
    });
  }

  int? getNumTasksUnFinished(int indexTask){
    return planDTO.taskList![indexTask].subTaskList?.fold(0, (t, e) => e.isFinish! ? t : (t! + 1));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Stack(
                  children: [
                    const Align(alignment: Alignment.centerLeft, child: Text("Plans")),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          Get.to(() => PlanPage("user"))?.then((value) => {
                            Get.back()
                          });
                        },
                        child: loading ? LoadingWidget(loading: loading) : Container(
                          child: const Icon(
                            Icons.add,
                            size: 22,
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
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.planDTO.duration! * 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                ),
                                const SizedBox(height: 12,),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Text(widget.planDTO.title!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                                      const SizedBox(width: 6,),
                                      Text("Day ${index + 1} of ${widget.planDTO.duration! * 7}")
                                    ],
                                  ),
                                ),
                                Container(height: 1, width: MediaQuery.of(context).size.width, color: Colors.black38,),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Text(widget.planDTO.taskList![index].taskDescription!, overflow: TextOverflow.clip,),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            const Text("Tasks", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                                            const SizedBox(width: 6,),
                                            Container(
                                                width: 25,
                                                height: 25,
                                                decoration: const BoxDecoration(
                                                    color: Colors.black12,
                                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                                ),
                                                child: Center(child: Text(getNumTasksUnFinished(index).toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),))
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: widget.planDTO.taskList![index].subTaskList!.length,
                                              itemBuilder: (context, id) {
                                                SubTask subTask = widget.planDTO.taskList![index].subTaskList![id];
                                                return SubTaskItem(
                                                    subTask,
                                                    () {
                                                      toggleSubTask(index, id);
                                                    }
                                                );
                                              }
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: Center(child: Text("${weekDays[currentDate.weekday]}, ${months[currentDate.month]} ${currentDate.day}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),))),
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
                        if(currentDay > 0){
                          currentDay = currentDay - 1;
                          changeCurrentDate(-1);
                          _scrollController.scrollTo(index: currentDay, duration: const Duration(milliseconds: 500));
                        }
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
                        if(currentDay < widget.planDTO.duration! * 7 - 1){
                          currentDay = currentDay + 1;
                          changeCurrentDate(1);
                          _scrollController.scrollTo(index: currentDay, duration: const Duration(milliseconds: 500));
                        }
                      },
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}

