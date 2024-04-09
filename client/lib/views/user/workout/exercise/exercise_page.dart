import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/workout/exercise/child_page/browse_all_page.dart';
import 'package:do_an_2/views/user/workout/exercise/child_page/history_page.dart';
import 'package:do_an_2/views/user/workout/exercise/child_page/my_exercise_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExercisePage extends GetView<ExercisePage> {

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
          title: Stack(
            children: [
              Text('Cardio'),
            ],
          ),

          bottom: const TabBar(
            tabs: [
              Tab(text: 'History'),
              Tab(text: 'My Exercise'),
              Tab(text: 'Browse all'),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}