import 'package:do_an_2/views/admin/meal_management/category/category_page.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/discover_recipes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'discover_recipes/discover_recipes_page.dart';
import 'meal_management_controller.dart';

class MealManagementPage extends GetView<MealManagementController> {
  MealManagementPage({super.key});

  final List<Widget> _tabs = [
    DiscoverRecipesPage(),
    MealCategoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Discover Recipes Management"),
          bottom: TabBar(
            onTap: (index) {
              switch (index) {
                case 0:
                  Get.find<DiscoverRecipesController>().getAllMealDiscover();
                  break;
                case 1:
                 controller.getAllMealCategory();
                  break;
              }
            },
            tabs: const [
              SizedBox(
                width: double.maxFinite,
                child: Tab(text: 'DISCOVER RECIPES'),
              ),
              SizedBox(width: double.maxFinite, child: Tab(text: 'CATEGORY')),
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
