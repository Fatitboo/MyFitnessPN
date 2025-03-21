import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:do_an_2/views/user/food_overview/meal/add_meal_item/add_meal_item_controller.dart';
import 'package:do_an_2/views/user/food_overview/meal/add_meal_item/f.dart';
import 'package:do_an_2/views/user/food_overview/meal/add_meal_item/htr.dart';
import 'package:do_an_2/views/user/food_overview/meal/add_meal_item/r.dart';
import 'package:do_an_2/views/user/food_overview/page/all_page.dart';
import 'package:do_an_2/views/user/food_overview/page/my_foods.dart';
import 'package:do_an_2/views/user/food_overview/page/my_meals.dart';
import 'package:do_an_2/views/user/food_overview/page/my_recipes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'm.dart';

class AddMealItemPage extends GetView<AddMealItemController> {
  AddMealItemPage({super.key});

  final List<Widget> _tabs = [
    HtrP(),
    MP(),
    RP(),
    FP(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: const Text("Add meal item"),
          bottom: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.w500, color: AppColor.black, fontSize: 16),
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            tabs: const [
              Tab(
                text: 'All',
              ),
              Tab(text: 'My Meals'),
              Tab(text: 'My Recipes'),
              Tab(text: 'My Foods'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: _tabs,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
