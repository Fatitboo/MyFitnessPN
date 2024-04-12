import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:do_an_2/views/user/food_overview/page/all_page.dart';
import 'package:do_an_2/views/user/food_overview/page/my_foods.dart';
import 'package:do_an_2/views/user/food_overview/page/my_meals.dart';
import 'package:do_an_2/views/user/food_overview/page/my_recipes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FoodOverviewPage extends GetView<FoodOverviewController> {
  FoodOverviewPage({super.key});

  final List<Widget> _tabs = [
    AllPage(),
    MyMealPage(),
    MyRecipesPage(),
    MyFoodsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primaryColor1,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            centerTitle: true,
            title: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  controller.selectedMeal.value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                items: controller.itemsMeal
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                            ),
                          ),
                        ))
                    .toList(),
                value: controller.selectedMeal.value,
                onChanged: (String? value) {
                  controller.onChangeValueDropdownBtn(value!);
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                  elevation: 0,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 112,
                  padding: const EdgeInsets.only(top: 6),
                  color: AppColor.primaryColor1,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  offset: Offset(0, 1))
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: controller.txtSearch,
                              decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                hintText: "Search",
                              ),
                            )),
                            InkWell(
                                onTap: () {}, child: const Icon(Icons.close))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TabBar(
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold
                        ),

                        tabAlignment: TabAlignment.center,
                        isScrollable: true,
                        onTap: (index) {
                          controller.onClickTopTabItem(index);
                        },
                        tabs: const [
                          Tab(text: 'All'),
                          Tab(text: 'My Meals'),
                          Tab(text: 'My Recipes'),
                          Tab(text: 'My Foods'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(

                  height: MediaQuery.of(context).size.height*0.8,
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
    });
  }
}
