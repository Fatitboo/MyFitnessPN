import 'package:do_an_2/model/mealDTO.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../res/values/color_extension.dart';
import 'add_meal_item_controller.dart';


class MP extends GetView<AddMealItemController> {
  const MP({super.key});


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Text(
                "My Meals",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: media.height * 0.8  - 50,
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.myMeal.length,
                      itemBuilder: (BuildContext context, int index) {
                        MealDTO m = controller.myMeal.value.elementAt(index);
                        return GestureDetector(
                          onTap: () {},

                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            margin:
                            const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
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
                                      m.description ?? "",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      m.getStringDescription(),
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        color: AppColor.primaryColor1
                                            .withOpacity(0.1)
                                    ),
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
