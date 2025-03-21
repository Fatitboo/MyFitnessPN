import 'package:do_an_2/model/foodDTO.dart';
import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/user/food_overview/recipe/add_recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';

class AddRecipePage extends GetView<AddRecipeController> {
  const AddRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery
        .of(context)
        .size;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: controller.type.value == "edit"
              ? const Text("Update recipe")
              : const Text("Create a recipe"),
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 1,
          actions: [
            IconButton(onPressed: () {
              if(controller.type.value == "edit"){
                controller.handleUpdateRecipe();
              }else{
                controller.handleAddRecipe();
              }
            }, icon: const Icon(Icons.check))
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recipe Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Required",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: controller.formController["title"],
                                onChanged: (item) {
                                  controller.errors["title"]?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller
                                            .errors["title"]!.isError
                                        ? controller.errors["title"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Ex: Chicken soup"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade300,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Number Of Serving",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Required",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(
                                minWidth: 100,
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: controller.formController["numberOfServing"],
                                onChanged: (item) {
                                  controller.errors["numberOfServing"]?.isError = false;
                                },
                                onSubmitted: (item) {
                                  controller.onChangeSize(item);
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller.errors["numberOfServing"]!.isError
                                        ? controller.errors["numberOfServing"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "1"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.primaryColor1.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Ingredients",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.INGREDIENTS);
                            },
                            child: const Text("Add", style: TextStyle(color: Colors.blueAccent),)),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: controller.myIngredients.length*70,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.myIngredients.length,
                            itemBuilder: (BuildContext context, int index) {
                              FoodDTO h = controller.myIngredients.elementAt(index);
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.LOG_FOOD,
                                      parameters: {
                                        "type": "fromAddRecipePage",
                                        "index": "$index"
                                      },
                                      arguments: controller);
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
                                            h.foodName ?? "",
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            h.getStringDescription() ?? "",
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.myIngredients.removeAt(index);
                                          controller.update();
                                          controller.updateData();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.transparent
                                          ),
                                          child:  Icon(Icons.delete_forever_outlined, color: Colors.red.withOpacity(0.7)),
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
                ),
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    controller.isShow.value = !controller.isShow.value;
                  },
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  dividerColor: AppColor.primaryColor1.withOpacity(0.3),
                  elevation: 1,
                  children: [
                    ExpansionPanel(
                      body: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Calories (Cal)",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller:
                                      controller.formController["calories"],
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Fat total (g)",
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller:
                                      controller.formController["fat_total_g"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Fat saturated (g)",
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: controller.formController["fat_saturated_g"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Cholesterol (mg)",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: controller.formController["cholesterol_mg"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Protein (g)",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: controller.formController["protein_g"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Sodium (mg)",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller:
                                      controller.formController["sodium_mg"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Potassium (mg)",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller:
                                      controller.formController["potassium_mg"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Carbohydrates total (g)",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: controller
                                          .formController["carbohydrates_total_g"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Fiber (g)",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller:
                                      controller.formController["fiber_g"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Sugar (g)",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller:
                                      controller.formController["sugar_g"],
                                      enabled: false,
                                      style: const TextStyle(fontSize: 13),
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Get.parameters["type"] == "add"
                                ? const SizedBox(height: 0)
                                :Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 45, right: 45, bottom: 25, top: 10),
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(side: const BorderSide(width: 1, color: Colors.red)),
                                        onPressed: () {
                                          // controller.deleteFood();
                                        },
                                        child: const Text("Delete", style: TextStyle(fontSize: 16, color: Colors.red),)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      isExpanded: controller.isShow.value,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // color: AppColor.primaryColor1.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                !controller.isShow.value
                                    ? const Text(
                                  "Show Nutrition Facts per serving",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                                    : const Text(
                                  "Hide Nutrition Facts per serving",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      );
    });
  }
}
