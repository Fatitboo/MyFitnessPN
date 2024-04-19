import 'package:do_an_2/model/historyDTO.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPage extends GetView<FoodOverviewController> {
  const AllPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery
        .of(context)
        .size;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColor.primaryColor1.withOpacity(0.3),
            height: media.width / 3,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/scan_a_food.png",
                            width: media.width / 10,
                            color: Colors.indigo.withOpacity(0.8),),
                          SizedBox(
                            height: media.width / 40,
                          ),
                          Text(
                            'Scan a Meal',
                            style: TextStyle(fontWeight: FontWeight.w600,
                                color: Colors.indigo.withOpacity(0.8)),
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
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/scan_barcode.png",
                            width: media.width / 9, color: Colors.indigo
                                .withOpacity(0.8)),
                        SizedBox(
                          height: media.width / 40,
                        ),
                        Text(
                          'Scan a Barcode',
                          style: TextStyle(fontWeight: FontWeight.w600,
                              color: Colors.indigo.withOpacity(0.8)),
                        )
                      ],
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
                "History",
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
                      itemCount: controller.myHistory.length,
                      itemBuilder: (BuildContext context, int index) {
                        HistoryDTO h = controller.myHistory.elementAt(
                            index);
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
                                      h.title ?? "",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      h.description ?? "",
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
