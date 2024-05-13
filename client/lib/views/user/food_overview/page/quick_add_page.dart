import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/food_overview/add_food/add_food_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickAddPage extends GetView<AddFoodController> {
  const QuickAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: const Text("Quick add"),
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Meal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          Container(
                            constraints: BoxConstraints(minWidth: 100, maxHeight: 40, maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: DropdownButtonFormField2<String>(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 10, right: 10),
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder()),
                                hint: Text(
                                  controller.selectedMeal.value,
                                  style:
                                  const TextStyle(fontSize: 14),
                                ),
                                items: controller.itemsMeal
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                onChanged: (value) {
                                  controller.selectedMeal.value =
                                      value.toString();
                                },
                                buttonStyleData:
                                const ButtonStyleData(
                                  padding: EdgeInsets.only(right: 8),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.transparent,
                                  ),
                                  iconSize: 24,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                  ),
                                ),
                                menuItemStyleData:
                                const MenuItemStyleData(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16),
                                ),
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
                          "Nutrition Facts per serving",
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
