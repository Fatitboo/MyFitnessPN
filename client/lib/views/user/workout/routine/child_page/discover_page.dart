import 'dart:convert';

import 'package:do_an_2/views/common_widgets/routine_explore_item_user.dart';
import 'package:do_an_2/views/user/workout/routine/routine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../../model/routineCategoryDTO.dart';
import '../../../../../model/routineDTO.dart';
import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/loading_widget.dart';

class DiscoverPage extends GetView<RoutineController> {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: LoadingWidget(loading: controller.loading.value)),
          Expanded(
            child: ListView.builder(
                itemCount: controller.listCategory.length,
                itemBuilder: (BuildContext ct, int index) {
                  RoutineCategoryDTO routineCategoryDTO = controller.listCategory.value.elementAt(index);
                  List<dynamic> listRoutine = controller.getRoutinesBy(routineCategoryDTO.routCategoryId!);
                  print(listRoutine);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(routineCategoryDTO.name!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
                                const SizedBox(height: 5,),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width - 40,
                                    child: Text(maxLines: 3,routineCategoryDTO.description!, style: const TextStyle(color: Colors.black54, fontSize: 16),))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 333,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listRoutine.length,
                                  itemBuilder: (BuildContext ct, int index) {
                                    RoutineDTO routineDTO = listRoutine.elementAt(index) as RoutineDTO;
                                    print(routineDTO.routineName);
                                    QuillController quill = QuillController.basic();
                                    quill.document = Document.fromJson(jsonDecode(routineDTO.workoutOverview.toString()));
                                    return Container(
                                      color: Colors.white,
                                      child: RoutineExploreItemUserWidget(
                                        routId: routineDTO.routId ?? "",
                                        routineName: routineDTO.routineName ?? "",
                                        duration: routineDTO.duration.toString(),
                                        thumbNail: routineDTO.thumbNail.toString(),
                                        type: routineDTO.type.toString(),
                                        category: routineDTO.category.toString(),
                                        workoutOverview: quill,
                                        callBack: (type) {
                                        },
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
            ),
          ),
        ],
      ),
    ));
  }
}