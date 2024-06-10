import 'dart:io';

import 'package:do_an_2/model/recipeDTO.dart';
import 'package:do_an_2/views/user/food_overview/pick_image/pick_image_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import '../../../../model/detectResponseDTO.dart';
import '../../../../model/foodDTO.dart';
import '../../../../res/routes/names.dart';
import '../../../../res/values/color_extension.dart';
import '../../../../res/widgets/loading_widget.dart';
import '../../../../res/widgets/round_button.dart';
import 'package:image/image.dart' as imglib;

class PickImagePage extends GetView<PickImageController> {
  const PickImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Pick image",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1,
            shadowColor: Colors.black,
            actions: [
              IconButton(
                  onPressed: () {
                    controller.logFood();
                  },
                  icon: const Icon(Icons.check))
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Stack(children: [
                Container(
                    height: MediaQuery.of(context).size.width / 1.5,
                    width: double.maxFinite,
                    child: controller.thumbnail.value.path.isNotEmpty
                        ? ClipRect(
                            child: Image.file(
                              File(controller.thumbnail.value.path),
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return const Center(child: Text('This image type is not supported'));
                              },
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container()),
                Container(
                    height: MediaQuery.of(context).size.width / 1.5,
                    width: double.maxFinite,
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          controller.chooseType(context);
                        },
                        child: Image.asset(
                          "assets/icons/camera_tab.png",
                          opacity: const AlwaysStoppedAnimation(.5),
                        ))),

              ]),
              SizedBox(
                height: 0.5,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.grey,
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {},
                    child: controller.loading.value ? LoadingWidget(loading: controller.loading.value) : Container(),
                  )),
              controller.myPredictRecipes.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.primaryColor1.withOpacity(0.2),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Predict Recipes",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                SizedBox(height: 0)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3 * 70,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: controller.myPredictRecipes.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      RecipeDTO h = controller.myPredictRecipes.elementAt(index);
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
                                                      width: MediaQuery.of(context).size.width * 70 / 100,
                                                      child: Text(
                                                        "${h.foods?.first.foodName} ",
                                                        style: const TextStyle(fontSize: 16),
                                                        overflow: TextOverflow.ellipsis,
                                                      )),
                                                  Text(
                                                    h.getCaloriesDesStr(),
                                                    style: const TextStyle(color: Colors.black54),
                                                  )
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed(AppRoutes.LOG_FOOD, parameters: {"type": "fromPickImgRecipePage", "index": "$index"});
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                                                  child: Icon(Icons.add, color: Colors.green.withOpacity(0.7)),
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
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.myPredictFoods.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: AppColor.primaryColor1.withOpacity(0.2),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Detect Ingredient of food",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                SizedBox(height: 0)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4 * 70,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: controller.myPredictFoods.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      FoodDTO h = controller.myPredictFoods.elementAt(index);
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
                                              Container(
                                                height: 100,
                                                width: 100,
                                                color: Colors.transparent,
                                                child: CustomPaint(
                                                  size: const Size(100, 100), // Kích thước của phần hình ảnh hiển thị
                                                  painter: ImageCropPainter(
                                                      context: context,
                                                      image: controller.loadedImage,
                                                      roi: controller.myRois.elementAt(index == 0 ? 0 : index % controller.myRois.length)),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: MediaQuery.of(context).size.width * 35 / 100,
                                                      child: Text(
                                                        "${h.foodName}",
                                                        style: const TextStyle(fontSize: 16),
                                                        overflow: TextOverflow.ellipsis,
                                                      )),
                                                  SizedBox(
                                                      width: MediaQuery.of(context).size.width * 30 / 100,
                                                      child: Text(
                                                        h.getStringDescription(),
                                                        style: const TextStyle(color: Colors.black54),
                                                      )),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (!controller.myFood.any((element) => element.foodName == h.foodName)) {
                                                    Get.toNamed(AppRoutes.LOG_FOOD,
                                                        parameters: {"type": "fromPickImgIngredientPage", "index": "$index"});
                                                  } else {
                                                    Get.defaultDialog(
                                                      radius: 8,
                                                      title: "Existed food?",
                                                      middleText: "This food is existed in list ingredient.",
                                                      textCancel: "Dismiss",
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                                                  child: Icon(Icons.add, color: Colors.green.withOpacity(0.7)),
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
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.myPredictRecipes.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundButton(
                          title: "Seft Add",
                          onPressed: () {
                            controller.isSeftAdd.value = true;
                            controller.formController["numberOfServing"]!.text = "${1.0}";
                          }),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              controller.isSeftAdd.value
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                        width: MediaQuery.of(context).size.width - 40,
                                        child: Text(controller.formController["description"]!.text,
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 0)
                                ],
                              ),
                              Container(
                                height: 0.5,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.shade300,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Number Of Serving",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        constraints: BoxConstraints(minWidth: 70, maxHeight: 40, maxWidth: MediaQuery.of(context).size.width),
                                        child: IntrinsicWidth(
                                          child: TextField(
                                            controller: controller.formController["numberOfServing"],
                                            textAlign: TextAlign.right,
                                            onSubmitted: (item) {
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Meal",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
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
                                            items: controller.itemsMeal
                                                .map((item) => DropdownMenuItem<String>(
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
                                              controller.selectedMeal.value = value.toString();
                                            },
                                            buttonStyleData: const ButtonStyleData(
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
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                            ),
                                            menuItemStyleData: const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(horizontal: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey.shade300,
                                  ),
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
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
                                              controller: controller.formController["calories"],
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
                                              controller: controller.formController["fat_total_g"],
                                              enabled: false,
                                              style: const TextStyle(fontSize: 13),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
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
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
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
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
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
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
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
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                          child: IntrinsicWidth(
                                            child: TextField(
                                              controller: controller.formController["protein_g"],
                                              enabled: false,
                                              style: const TextStyle(fontSize: 13),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
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
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                          child: IntrinsicWidth(
                                            child: TextField(
                                              controller: controller.formController["sodium_mg"],
                                              enabled: false,
                                              style: const TextStyle(fontSize: 13),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
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
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                          child: IntrinsicWidth(
                                            child: TextField(
                                              controller: controller.formController["potassium_mg"],
                                              enabled: false,
                                              style: const TextStyle(fontSize: 13),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
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
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                          child: IntrinsicWidth(
                                            child: TextField(
                                              controller: controller.formController["carbohydrates_total_g"],
                                              enabled: false,
                                              style: const TextStyle(fontSize: 13),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
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
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                          child: IntrinsicWidth(
                                            child: TextField(
                                              controller: controller.formController["fiber_g"],
                                              enabled: false,
                                              style: const TextStyle(fontSize: 13),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
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
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                                          child: IntrinsicWidth(
                                            child: TextField(
                                              controller: controller.formController["sugar_g"],
                                              enabled: false,
                                              style: const TextStyle(fontSize: 13),
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                              )
                                            : const Text(
                                                "Hide Nutrition Facts per serving",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Meal item",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                (controller.type.value == "logMeal" ||
                                        controller.type.value == "updateLogMeal" ||
                                        controller.type.value == "logMealFromDiscoverPage")
                                    ? const SizedBox(height: 0)
                                    : InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.INGREDIENTS, parameters: {"type": "fromPickImg"});
                                        },
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(color: Colors.blueAccent),
                                        )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: controller.myFood.length * 70,
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
                                                      width: MediaQuery.of(context).size.width * 68 / 100,
                                                      child: Text(
                                                        "${h.numberOfServing! * h.servingSize!} g ${h.foodName} " ?? "",
                                                        style: const TextStyle(fontSize: 16),
                                                        overflow: TextOverflow.ellipsis,
                                                      )),
                                                  Text(
                                                    h.getCalDes(),
                                                    style: const TextStyle(color: Colors.black54),
                                                  )
                                                ],
                                              ),
                                              InkWell(
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
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          // color: AppColor.primaryColor1.withOpacity(0.2),

                          decoration: const BoxDecoration(),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Direction",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                SizedBox(width: 0)
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
                            decoration: const InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none, hintText: "1. ..."),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ],
          )));
    });
  }
}

class ImageCropPainter extends CustomPainter {
  ImageCropPainter({required this.context, required this.image, required this.roi});
  final Roi roi;
  ui.Image? image;
  final BuildContext context;
  @override
  void paint(Canvas canvas, Size size) {
    double x = (roi.x).toDouble();
    double y = (roi.y).toDouble();
    double height = (roi.height).toDouble() - x;
    double width = (roi.width).toDouble() - y;
    if (image != null) {
      canvas.drawImageRect(
        image!,
        Rect.fromLTWH(y, x, width, height),
        width <= height ? Rect.fromLTWH(0, 0, width * size.height / height, size.height) :
        Rect.fromLTWH(0, 0, size.width, height * size.width / width),
        Paint(),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
