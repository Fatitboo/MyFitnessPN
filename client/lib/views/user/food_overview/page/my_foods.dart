import 'package:do_an_2/model/foodDTO.dart';
import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';

class MyFoodsPage extends GetView<FoodOverviewController> {
  const MyFoodsPage({super.key});


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.yellow.withOpacity(0.2),
            height: media.width / 3,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.ADD_FOOD,
                          parameters: {"type":"add"}
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/apple.png", width: media.width / 10, color: Colors.orange.withOpacity(0.9),),
                          SizedBox(height: media.width / 40,),
                          Text('Create a Food', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.orange.shade800),)
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
                    onTap: (){
                      Get.toNamed(AppRoutes.QUICK_ADD,
                      parameters: {"type":"quickAdd"});
                    },
                    child: Container(
                      decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/fire.png", width: media.width / 10),
                          SizedBox(height: media.width / 40,),
                          Text('Quick Add', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.orange.shade800),
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
              child: Text("My Foods", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),
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
                      itemCount: controller.myFood.length,
                      itemBuilder: (BuildContext context, int index) {
                        FoodDTO f = controller.myFood.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.LOG_FOOD, parameters: {"index":"$index", "type":"fromMyFoodPage"}, arguments: controller);
                          },
                          onLongPress: (){
                            Get.toNamed(
                              AppRoutes.ADD_FOOD,
                              parameters: {"type": "edit", "index": "$index"});
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
                                    Text(f.foodName ?? "", style: const TextStyle(fontSize: 16),),
                                    Text(f.getStringDescription(), style: const TextStyle(color: Colors.black54),)
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: AppColor.primaryColor1.withOpacity(0.1)
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
