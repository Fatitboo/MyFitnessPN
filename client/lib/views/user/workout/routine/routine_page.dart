import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/user/workout/routine/add_routine_page.dart';
import 'package:do_an_2/views/user/workout/routine/child_page/discover_page.dart';
import 'package:do_an_2/views/user/workout/routine/child_page/my_routine.dart';
import 'package:do_an_2/views/user/workout/routine/routine_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/values/color_extension.dart';

class RoutinePage extends GetView<RoutineController> {

  final List<Widget> _tabs = [
    DiscoverPage(),
    MyRoutinePage()
  ];

  RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Workout Routines"),
          bottom: TabBar(
            onTap: (index){
              controller.onClickTopTabItem(index);
            },
            tabs: const [
              Tab(text: 'EXPLORE'),
              Tab(text: 'MY ROUTINE'),
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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                             backgroundColor: const Color(0xff0167f0),
                          ),
                          onPressed: () {
                              Get.toNamed(AppRoutes.ADD_ROUTINE, arguments: {"type": "create"})?.then(
                                      (value) => {
                                    controller.resetValue()
                                  }
                              );
                          },
                          child: Text("Build Routine", style: TextStyle(fontSize: 16, color: AppColor.white, fontWeight: FontWeight.w800),)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}