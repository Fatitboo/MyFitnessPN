
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/workout/exercise/child_page/browse_all_page.dart';
import 'package:do_an_2/views/user/workout/exercise/child_page/history_page.dart';
import 'package:do_an_2/views/user/workout/exercise/child_page/my_exercise_page.dart';
import 'package:do_an_2/views/user/workout/exercise/exercise_controller.dart';
import 'package:do_an_2/views/user/workout/exercise/form/exercise_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExercisePage extends GetView<ExerciseController> {

  final List<Widget> _tabs = [
    HistoryPage(),
    MyExercisePage(),
    BrowseAllPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.currentWorkoutType.value),
          bottom: TabBar(
            onTap: (index){
              controller.onClickTopTabItem(index);
            },
            tabs: const [
              SizedBox(
                width: double.maxFinite,
                child: Tab(text: 'HISTORY'),
              ),
              SizedBox(
                  width: double.maxFinite,
                  child: Tab(text: 'MY EXERCISES')
              ),
              SizedBox(
                  width: double.maxFinite,
                  child: Tab(text: 'BROWSER ALL')
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
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) => ExerciseForm(context: context, exerciseController: controller, typeForm: "create",)
                            );
                          },
                          child: Text("Create an Exercise", style: TextStyle(fontSize: 16, color: AppColor.OutlineButtonColor),)
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