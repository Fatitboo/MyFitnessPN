import 'package:do_an_2/model/recipeDTO.dart';
import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';

class MyRecipesPage extends GetView<FoodOverviewController> {
  const MyRecipesPage({super.key});
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColor.secondaryColor1.withOpacity(0.1),
            height: media.width / 3,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.ADD_RECIPE, parameters: {"type": "add"}, arguments: Get.arguments);
                    },
                    child: Container(
                      decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_business_outlined, size: media.width / 10, color: Colors.purple),
                          SizedBox(
                            height: media.width / 40,
                          ),
                          const Text(
                            'Create a Recipe',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.purple),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.DISCOVER_RECIPES_MANAGEMENT, parameters: {"type": "fromUserDiscoverRecipe"});
                    },
                    child: Container(
                      decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_tree_outlined,
                            size: media.width / 10,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            height: media.width / 40,
                          ),
                          const Text(
                            'Discover the Recipe',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.purple),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Text(
                "My Recipes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: media.height * 0.8 - media.width / 3 - 50,
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.myRecipe.length,
                      itemBuilder: (BuildContext context, int index) {
                        RecipeDTO r = controller.myRecipe.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.LOG_FOOD, parameters: {"type": "fromMyRecipePage", "index": "$index"}, arguments: controller);
                          },
                          onLongPress: () {
                            Get.toNamed(AppRoutes.ADD_RECIPE, parameters: {"type": "edit", "index": "$index"}, arguments: Get.arguments);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      r.title ?? "",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      r.getStringDescription(),
                                      style: const TextStyle(color: Colors.black54),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColor.primaryColor1.withOpacity(0.1)),
                                    child: const Icon(Icons.add),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
