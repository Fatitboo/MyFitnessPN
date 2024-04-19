import 'package:do_an_2/views/user/food_overview/log_food/log_food_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';

class LogFoodPage extends GetView<LogFoodController> {
  const LogFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: (Get.parameters["type"] == "fromIngredientPage")
              ||(Get.parameters["type"] == "fromAddRecipePage")
              ? const Text("Confirm ingredient")
              : (Get.parameters["type"] == "fromAddMealItemRecipePage")
              ||(Get.parameters["type"] == "fromAddMealItemFoodPage")
              ? const Text("Confirm meal item")
              : const Text("Log food"),
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  if(Get.parameters["type"] == "fromMyFoodPage"){
                    // controller.logFood();
                  }
                  if(Get.parameters["type"] == "fromIngredientPage"
                      || Get.parameters["type"] == "fromAddRecipePage"){
                    controller.logIngredientToRecipe();
                  }
                  if((controller.type.value == "fromAddMealItemRecipePage")
                  ||(controller.type.value == "fromAddMealItemFoodPage")){
                    controller.logMealItemToMeal();
                  }
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.fname.value,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                controller.fdes.value,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(height: 0.5, width: MediaQuery.of(context).size.width, color: Colors.grey.shade300,),
                      const SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Serving Size (g)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          Container(
                            constraints: BoxConstraints(minWidth: 70, maxHeight: 40, maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: controller.formController["servingSize"],
                                onChanged: (item) {controller.errors["servingSize"]?.isError = false;},
                                onSubmitted: (item) {controller.onChangeSize(item);},
                                enabled: (Get.parameters["type"] == "fromMyRecipePage"||Get.parameters["type"] == "fromAddRecipePage"||Get.parameters["type"] == "fromAddMealItemRecipePage")?false:true,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(top: 10, right: 10), enabledBorder: const OutlineInputBorder(),
                                    errorText: controller.errors["servingSize"]!.isError
                                        ? controller.errors["servingSize"]!.message
                                        : null,
                                    focusedBorder:  const OutlineInputBorder(),
                                    hintText: "2"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Number Of Serving", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          Container(
                            constraints: BoxConstraints(minWidth: 70, maxHeight: 40, maxWidth: MediaQuery.of(context).size.width),
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
                                    contentPadding: const EdgeInsets.only(top: 10, right: 10),
                                    enabledBorder: const OutlineInputBorder(),
                                    errorText: controller.errors["numberOfServing"]!.isError
                                        ? controller.errors["numberOfServing"]!.message
                                        : null,
                                    focusedBorder: const OutlineInputBorder(),
                                    hintText: "1"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      (controller.type.value== "fromIngredientPage")||(controller.type.value == "fromAddRecipePage")
                          ||(controller.type.value == "fromAddMealItemRecipePage")
                          ? const SizedBox(height: 0,)
                          : Column(
                              children: [
                                const SizedBox(height: 20,),
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
                            )
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
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
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
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width),
                                  child: IntrinsicWidth(
                                    child: TextField(
                                      controller: controller
                                          .formController["fat_saturated_g"],
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
                            (Get.parameters["type"] == "fromIngredientPage")
                                ||(Get.parameters["type"] == "fromAddRecipePage")
                                ||(Get.parameters["type"] == "fromAddMealItemRecipePage")
                                ||(Get.parameters["type"] == "fromAddMealItemFoodPage")
                                ?const SizedBox(height: 0,)
                                : Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 45, right: 45, bottom: 25, top: 10),
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(side: const BorderSide(width: 1, color: Colors.red)),
                                        onPressed: () {
                                          controller.deleteItem();
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
                                    ? const Text("Show Nutrition Facts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                )
                                    : const Text("Hide Nutrition Facts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
