import 'package:do_an_2/model/mealByCategory.dart';
import 'package:do_an_2/model/mealDTO.dart';
import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/discover_recipes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/values/color_extension.dart';
import '../../../../res/widgets/loading_widget.dart';

class DiscoverRecipesPage extends GetView<DiscoverRecipesController> {
  const DiscoverRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: (controller.typeNav.value == "fromUserDiscoverRecipe")
              ? AppBar(
            backgroundColor: AppColor.white,
            title:  const Text("Discover Recipe"),
            centerTitle: true,
            shadowColor: Colors.black,
            elevation: 1,
          ):null,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
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
                              controller.getDiscoverRecipeFromApi(value);
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
                            controller.resetHis();
                          },
                          child: const Icon(Icons.close))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(child: LoadingWidget(loading: controller.loading.value)),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listMealByCategory.length,
                      itemBuilder: (BuildContext ct, int index) {
                        MealByCategoryDTO m = controller.listMealByCategory.elementAt(index);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                m.mealType??"",
                                style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600,

                              ),),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 1 / 4,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: m.meals?.length,
                                          itemBuilder:
                                              (BuildContext ct, int index) {
                                            MealDTO? meal = m.meals?.elementAt(index);
                                            return InkWell(
                                              onTap: (){
                                                if(controller.typeNav.value == "fromUserDiscoverRecipe"){
                                                  Get.toNamed(
                                                      AppRoutes.MEAL_ACTION,
                                                      parameters: {
                                                        "type":"logMealFromDiscoverPage",
                                                        "index":"$index",
                                                        "mealType": m.mealType ?? ""});
                                                }else{
                                                  Get.toNamed(
                                                      AppRoutes.DISCOVER_RECIPES_MANAGEMENT_ADD,
                                                      parameters: {"type": "editDis"},
                                                      arguments: {
                                                        "index": index,
                                                        "mealType": m.mealType ?? ""
                                                      }
                                                  );
                                                }

                                              },
                                              child: Container(
                                                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(2)),
                                                    boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]
                                                ),
                                                height: MediaQuery.of(context).size.height * (1/4),
                                                width: MediaQuery.of(context).size.width * 1/3 + 10,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: (MediaQuery.of(context).size.height * (1/4)) * 2/3 - 10,
                                                      width: MediaQuery.of(context).size.width * 1/3 + 10,
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.all(Radius.circular(2)),

                                                      ),
                                                      child: Image.network(meal!.photo??"https://res.cloudinary.com/dcdjan0oo/image/upload/v1715090638/admin/recipe/images/wp6ibavbkien9v2oqogw.jpg",
                                                      height:  (MediaQuery.of(context).size.height * (1/4)) * 2/3,
                                                      fit: BoxFit.fill,


                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                      child: Text(meal!.description??"" ,
                                                        style: const TextStyle(
                                                        fontSize: 14, fontWeight: FontWeight.w600,
                                                      ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8, ),
                                                      child: Text(meal.getCalories(), style: const TextStyle(fontSize: 12),),
                                                    ),

                                                  ],
                                                ),

                                              ),
                                            );
                                          }))
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                ),
                (controller.typeNav.value== "fromUserDiscoverRecipe")
                ? const SizedBox(height: 0,)
                : Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 1,
                                    color: AppColor.OutlineButtonColor)),
                            onPressed: () {
                              Get.toNamed(
                                  AppRoutes.DISCOVER_RECIPES_MANAGEMENT_ADD,
                                  parameters: {"type": "addDis"},
                                  arguments: Get.arguments);
                            },
                            child: Text(
                              "Create an Recipe",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.OutlineButtonColor),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
