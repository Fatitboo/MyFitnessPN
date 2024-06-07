
import 'package:do_an_2/model/recipeDTO.dart';
import 'package:do_an_2/views/user/food_overview/meal/meal_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/foodDTO.dart';
import '../../../../res/routes/names.dart';
import '../../../../res/values/color_extension.dart';

class MealPage extends GetView<MealController> {
  const MealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: controller.type.value == "createMeal"
              ? const Text("Create a meal")
              : controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
              || controller.type.value == "logMealFromDiscoverPage"
                  ? const Text("Log meal")
                  : const Text("Update meal"),
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 1,
          actions: [
            IconButton(onPressed: () {
              if(controller.type.value == "createMeal"){
                controller.handleAddMeal();
              }
              if(controller.type.value == "updateMeal"){
                controller.handleUpdateMeal();
              }
              if(controller.type.value == "logMeal" || controller.type.value =="updateLogMeal"
              || controller.type.value=="logMealFromDiscoverPage"){
                controller.logFood();
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
                Stack(
                  children:[
                     Container(
                            height: MediaQuery.of(context).size.width / 2,
                            width: double.maxFinite,
                            child: controller.thumbnail.value.path.isNotEmpty ? Image.file(controller.thumbnail.value):
                                 controller.thumbnailLink.value.isNotEmpty ?Image.network(controller.thumbnailLink.value, fit: BoxFit.fill,)
                                :Container()
                       ),
                    Container(
                        height: MediaQuery.of(context).size.width / 2,
                        width: double.maxFinite,
                        color: Colors.transparent,
                        child:  (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                        || controller.type.value == "logMealFromDiscoverPage")
                            ? const SizedBox(height: 0,)
                            : InkWell(
                          onTap: (){controller.pickThumbnail();},
                            child: Image.asset("assets/icons/camera_tab.png"))
                    ),
                   ]
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               SizedBox(
                                 width: MediaQuery.of(context).size.width-40,
                                 child: Text(
                                   (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                                       || controller.type.value == "logMealFromDiscoverPage")
                                       ? controller.formController["description"]!.text
                                   : "Meal name",
                                  style:const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w600),
                                   overflow: TextOverflow.ellipsis),
                               ),
                              (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                              || controller.type.value == "logMealFromDiscoverPage")
                              ? const SizedBox(height: 0)
                              : const Text("Required", style: TextStyle(fontSize: 14),),
                            ],
                          ),
                          (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                          || controller.type.value == "logMealFromDiscoverPage")
                          ? const SizedBox(height: 0)
                          : Container(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: IntrinsicWidth(
                              child: TextField(
                                controller:controller.formController["description"],
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: TextStyle(color: AppColor.black, ),
                                enabled: (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal") ? false : true,
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Ex: Chicken soup"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                          || controller.type.value == "logMealFromDiscoverPage")
                          ? const SizedBox(height: 0,)
                          :Container(height: 0.5, width: MediaQuery.of(context).size.width, color: Colors.grey.shade300,),
                      const SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal" || controller.type.value == "logMealFromDiscoverPage")
                          ?Text("${controller.formController["numberOfServing"]!.text} serving", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)
                          : const SizedBox(height: 10,),
                          const SizedBox(height: 10,),
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
                                    textAlign: TextAlign.right,
                                    onSubmitted: (item){
                                      controller.onChangeSize(item);
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 10, right: 10),
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        hintText: "1"),
                                  ),
                                ),
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
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    items: controller.itemsMeal.map((item) => DropdownMenuItem<String>(value: item,
                                      child: Text(item, style: const TextStyle(fontSize: 14,),),
                                    )).toList(),
                                    onChanged: (value) {
                                      controller.selectedMeal.value = value.toString();
                                    },
                                    buttonStyleData: const ButtonStyleData(padding: EdgeInsets.only(right: 8),),
                                    iconStyleData: const IconStyleData(icon: Icon(Icons.arrow_drop_down, color: Colors.transparent,), iconSize: 24,),
                                    dropdownStyleData: DropdownStyleData(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),),
                                    menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.symmetric(horizontal: 16),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Container(height: 0.5, width: MediaQuery.of(context).size.width, color: Colors.grey.shade300,),
                        ],
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
                                const Text("Calories (Cal)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
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
                            Container(height: 0.5, width: MediaQuery.of(context).size.width, color: Colors.grey.shade300,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Fat total (g)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),),
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
                            Container(height: 0.5, width: MediaQuery.of(context).size.width, color: Colors.grey.shade300,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Fat saturated (g)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),),
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
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),),
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
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
                           controller.type.value == "createMeal"
                               ||(controller.type.value == "logMeal"||controller.type.value == "updateLogMeal")
                          ? const SizedBox(height: 0)
                                :Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 45,
                                        right: 45,
                                        bottom: 25,
                                        top: 10),
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 1, color: Colors.red)),
                                        onPressed: () {
                                          // controller.deleteFood();
                                        },
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.red),
                                        )),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 6),
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
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.primaryColor1.withOpacity(0.2),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Meal item",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                            || controller.type.value == "logMealFromDiscoverPage")
                            ? const SizedBox(height: 0)
                            : InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.ADD_MEAL_ITEM);
                            },
                            child: const Text("Add", style: TextStyle(color: Colors.blueAccent),)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: controller.myFood.length*70,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.myFood.length,
                            itemBuilder: (BuildContext context, int index) {
                              FoodDTO h = controller.myFood.elementAt(index);
                              return GestureDetector(
                                onTap: () {},
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
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width*70/100,
                                              child: Text("${h.numberOfServing!*h.servingSize!} g ${h.foodName} "?? "", style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis,)),
                                          Text(h.getCalDes() , style: const TextStyle(color: Colors.black54),)
                                        ],
                                      ),
                                      (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                                          || controller.type.value == "logMealFromDiscoverPage")
                                          ? const SizedBox(height: 0)
                                          : InkWell(
                                        onTap: () {
                                          controller.myFood.removeAt(index);
                                          controller.updateData();
                                          controller.update();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                                          child: Icon(Icons.delete_forever_outlined, color: Colors.red.withOpacity(0.7)),
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
                SizedBox(
                  height: controller.myRecipe.length*70,
                  //MediaQuery.of(context).size.width-50
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.myRecipe.length,
                            itemBuilder: (BuildContext context, int index) {
                              RecipeDTO h = controller.myRecipe.elementAt(index);
                              return GestureDetector(
                                onTap: () {},
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
                                          SizedBox(
                                            width:MediaQuery.of(context).size.width*70/100,
                                            child: Text(
                                              "${h.numberOfServing} p ${h.title}" ?? "", style: const TextStyle(fontSize: 16,), overflow: TextOverflow.ellipsis,),
                                          ),
                                          Text(h.getCaloriesDesStr() , style: const TextStyle(color: Colors.black54),)
                                        ],
                                      ),
                                      (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                                          || controller.type.value == "logMealFromDiscoverPage")
                                          ? const SizedBox(height: 0)
                                          :InkWell(
                                        onTap: () {
                                          controller.myRecipe.removeAt(index);
                                          controller.updateData();
                                          controller.update();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                                          child: Icon(Icons.delete_forever_outlined, color: Colors.red.withOpacity(0.7)),
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
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  // color: AppColor.primaryColor1.withOpacity(0.2),

                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Direction", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
                        (controller.type.value == "logMeal"||controller.type.value == "updateLogMeal"
                            || controller.type.value == "logMealFromDiscoverPage")
                            ? const SizedBox(height: 0)
                            : InkWell(
                            onTap: () {
                              controller.isEnable.value = true;
                              controller.focusNode.requestFocus();

                            },
                            child: const Text(
                              "Edit",
                              style: TextStyle(color: Colors.blueAccent),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: controller.formController["direction"],
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(color: AppColor.black),
                    onSubmitted: (item){controller.isEnable.value = false;},
                    enabled: controller.isEnable.value ,
                    focusNode: controller.focusNode,
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "1. ..."),
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
