import 'package:do_an_2/model/planDTO.dart';
import 'package:do_an_2/views/user/plan/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../res/values/color_extension.dart';
import '../../../res/widgets/loading_widget.dart';

class PlanObserveUserPage extends GetView<PlanController> {
  PlanObserveUserPage(this.planDTO, {super.key});
  final ItemScrollController _scrollController = ItemScrollController();
  final PlanDTO planDTO;
  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Stack(
                  children: [
                    Align(alignment: Alignment.centerLeft, child: Text(planDTO.title!)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {

                        },
                        child: controller.loading.value ? LoadingWidget(loading: controller.loading.value) :Container(),
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
                    itemCount: planDTO.duration! * 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      ItemScrollController itemWeekScrollController = ItemScrollController();
                      return Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: Center(child: Text(controller.currentDate.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),))),
                          const SizedBox(height: 12,),
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
                        if(controller.currentDay.value > 0){
                          controller.currentDay.value = controller.currentDay.value - 1;
                        }
                        controller.changeCurrentDate(-1);
                        _scrollController.scrollTo(index: controller.currentDay.value, duration: const Duration(milliseconds: 500));
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
                        if(controller.currentDay.value < planDTO.duration! * 7 - 1){
                          controller.currentDay.value = controller.currentDay.value + 1;
                        }
                        controller.changeCurrentDate(1);
                        _scrollController.scrollTo(index: controller.currentDay.value, duration: const Duration(milliseconds: 500));
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

