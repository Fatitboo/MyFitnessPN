import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/add_discover_recipe/add_discover_recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../model/historyDTO.dart';
import '../../../../../../res/values/color_extension.dart';

class SearchIngredientAdminPage extends GetView<AddDiscoverRecipeController> {
  const SearchIngredientAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: const Text("Ingredients"),
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 1,
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(top: 16, bottom: 15),
                    color: AppColor.white,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(0),
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
                            onSubmitted: (value) {
                              controller.getFoodsFromApi(value);
                            },
                            controller: controller.txtSearch,
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColor.black,
                              ),
                              hintText: "Search",
                            ),
                          )),
                          InkWell(
                              onTap: () {
                                // controller.resetHis();
                                controller.txtSearch.clear();
                              },
                              child: const Icon(Icons.close))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 120,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: controller.myHistory.length,
                              itemBuilder: (BuildContext context, int index) {
                                HistoryDTO h =
                                    controller.myHistory.elementAt(index);
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              h.title ?? "",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              h.description ?? "",
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (!controller.myIngredients.any(
                                                (element) =>
                                                    element.foodName ==
                                                    h.title)) {
                                              Get.toNamed(AppRoutes.LOG_FOOD,
                                                  parameters: {
                                                    "type":
                                                        "fromIngredientAdminPage",
                                                    "index": "$index"
                                                  },
                                                  arguments: controller);
                                            } else {
                                              Get.defaultDialog(
                                                radius: 8,
                                                title: "Existed food?",
                                                middleText:
                                                    "This food is existed in list ingredient.",
                                                textCancel: "Dismiss",
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: AppColor.primaryColor1
                                                    .withOpacity(0.1)),
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
              ),
            )),
      );
    });
  }
}
