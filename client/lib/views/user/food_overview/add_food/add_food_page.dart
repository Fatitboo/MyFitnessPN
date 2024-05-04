import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/food_overview/add_food/add_food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFoodPage extends GetView<AddFoodController> {
  const AddFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: Get.parameters["type"] =="add"? const Text("Create food"):const Text("Update food"),
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  controller.handleAddOrUpdateFood();
                },
                icon: const Icon(Icons.check))
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
                                "Food Name",
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
                                controller:
                                    controller.formController["foodName"],
                                onChanged: (item) {
                                  controller.errors.value["foodName"]?.isError =
                                      false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,

                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller
                                            .errors.value["foodName"]!.isError
                                        ? controller
                                            .errors.value["foodName"]!.message
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
                                "Description",
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
                                controller:
                                    controller.formController["description"],
                                onChanged: (item) {
                                  controller.errors.value["description"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller.errors
                                            .value["description"]!.isError
                                        ? controller.errors
                                            .value["description"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Ex: Chicken, carrot"),
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
                                "Serving Size (g)",
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
                                controller:
                                    controller.formController["servingSize"],
                                onChanged: (item) {
                                  controller.errors.value["servingSize"]?.isError = false;

                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller.errors
                                            .value["servingSize"]!.isError
                                        ? controller.errors
                                            .value["servingSize"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "2"),
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
                                controller: controller
                                    .formController["numberOfServing"],
                                onChanged: (item) {
                                  controller.errors.value["numberOfServing"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller.errors
                                            .value["numberOfServing"]!.isError
                                        ? controller.errors
                                            .value["numberOfServing"]!.message
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
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.primaryColor1.withOpacity(0.3),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Nutrition Facts",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:
                                    controller.formController["calories"],
                                onChanged: (item) {
                                  controller.errors.value["calories"]?.isError =
                                      false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller
                                            .errors.value["calories"]!.isError
                                        ? controller
                                            .errors.value["calories"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Required"),
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:
                                    controller.formController["fat_total_g"],
                                onChanged: (item) {
                                  controller.errors.value["fat_total_g"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller.errors
                                            .value["fat_total_g"]!.isError
                                        ? controller.errors
                                            .value["fat_total_g"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: controller
                                    .formController["fat_saturated_g"],
                                onChanged: (item) {
                                  controller.errors.value["fat_saturated_g"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller.errors
                                            .value["fat_saturated_g"]!.isError
                                        ? controller.errors
                                            .value["fat_saturated_g"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:
                                    controller.formController["cholesterol_mg"],
                                onChanged: (item) {
                                  controller.errors.value["cholesterol_mg"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller.errors
                                            .value["cholesterol_mg"]!.isError
                                        ? controller.errors
                                            .value["cholesterol_mg"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:
                                    controller.formController["protein_g"],
                                onChanged: (item) {
                                  controller.errors.value["protein_g"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller
                                            .errors.value["protein_g"]!.isError
                                        ? controller
                                            .errors.value["protein_g"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:
                                    controller.formController["sodium_mg"],
                                onChanged: (item) {
                                  controller.errors.value["sodium_mg"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller
                                            .errors.value["sodium_mg"]!.isError
                                        ? controller
                                            .errors.value["sodium_mg"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:
                                    controller.formController["potassium_mg"],
                                onChanged: (item) {
                                  controller.errors.value["potassium_mg"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller.errors
                                            .value["potassium_mg"]!.isError
                                        ? controller.errors
                                            .value["potassium_mg"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: controller
                                    .formController["carbohydrates_total_g"],
                                onChanged: (item) {
                                  controller
                                      .errors
                                      .value["carbohydrates_total_g"]
                                      ?.isError = false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller
                                            .errors
                                            .value["carbohydrates_total_g"]!
                                            .isError
                                        ? controller
                                            .errors
                                            .value["carbohydrates_total_g"]!
                                            .message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:
                                    controller.formController["fiber_g"],
                                onChanged: (item) {
                                  controller.errors.value["fiber_g"]?.isError =
                                      false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller
                                            .errors.value["fiber_g"]!.isError
                                        ? controller
                                            .errors.value["fiber_g"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
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
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:
                                    controller.formController["sugar_g"],
                                onChanged: (item) {
                                  controller.errors.value["sugar_g"]?.isError =
                                      false;
                                },
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    errorText: controller
                                            .errors.value["sugar_g"]!.isError
                                        ? controller
                                            .errors.value["sugar_g"]!.message
                                        : null,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Optional"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
