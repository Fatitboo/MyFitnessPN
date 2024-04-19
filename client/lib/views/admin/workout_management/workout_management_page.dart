import 'package:do_an_2/views/admin/workout_management/exercise/exercise_controller.dart';
import 'package:do_an_2/views/admin/workout_management/exercise/exercise_page.dart';
import 'package:do_an_2/views/admin/workout_management/routine/category/category_page.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_page.dart';
import 'package:do_an_2/views/admin/workout_management/workout_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WorkoutManagementPage extends GetView<WorkoutManagementController> {
  WorkoutManagementPage({super.key});

  final List<Widget> _tabs = [
    MyExercisePage(),
    MyRoutinePage(),
    CategoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Workout Management"),
          bottom: TabBar(
            onTap: (index){
              switch(index){
                case 0:
                  Get.find<ExerciseController>().getAllExercise();
                  break;
                case 1:
                  Get.find<RoutineController>().setCategoryTypesList();
                  Get.find<RoutineController>().getAllRoutine();
                  break;
                case 2:
                  Get.find<RoutineController>().getAllRoutineCategory();
                  break;
              }
            },
            tabs: const [
              SizedBox(
                width: double.maxFinite,
                child: Tab(text: 'EXERCISE'),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Tab(text: 'ROUTINE'),
              ),
              SizedBox(
                  width: double.maxFinite,
                  child: Tab(text: 'CATEGORY')
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
