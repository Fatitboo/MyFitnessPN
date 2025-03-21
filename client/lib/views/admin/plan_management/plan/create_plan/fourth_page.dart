import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/my_button.dart';

class FourthPage extends GetView<PlanAdminController> {
  final VoidCallback back;
  final VoidCallback onTap;
  const FourthPage({super.key,  required this.back, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.weekDescriptions.value.length,
                    itemBuilder: (BuildContext ct, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15,),
                          Text("Week ${index + 1}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                          const SizedBox(height: 5,),
                          TextField(
                            controller: controller.weekDescriptions.value.elementAt(index),
                            decoration: InputDecoration(
                                hintText: "Type description",
                                // errorText: controller.errors["title"]!.isError ? controller.errors["title"]!.message : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                )
                            ),
                            keyboardType: TextInputType.multiline,
                          ),
                        ],
                      );
                    },
                  ),
                  Container(height: 80,)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: MyButton(
                          onTap: () {
                            back();
                          },
                          bgColor: AppColor.white,
                          textString: 'Back',
                          textColor: AppColor.blackText,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          children: [
                            MyButton(
                              onTap: () {
                                for(int i = 0; i < controller.weekDescriptions.value.length; i++){
                                  if(controller.weekDescriptions.value.elementAt(i).text.toString().isEmpty){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Warning"),
                                          content: Text("Week ${i + 1} must have value!"),
                                          actions: [
                                            TextButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                        return alert;
                                      },
                                    );
                                    return;
                                  }
                                }
                                onTap();
                              },
                              bgColor: AppColor.blackText,
                              textString: 'Next',
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
