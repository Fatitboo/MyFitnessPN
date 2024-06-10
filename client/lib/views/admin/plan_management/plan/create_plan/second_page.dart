import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/my_button.dart';

class SecondPage extends GetView<PlanAdminController>{
  final VoidCallback back;
  final VoidCallback onTap;
  const SecondPage({super.key,  required this.onTap, required this.back});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor3,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Thumbnail", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            const SizedBox(width: 10,),
                            Image.asset("assets/images/routineVideo.png",height: 120,)
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 150,
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Thumbnail',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.pickThumbnail();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Choose", style: TextStyle(color: Colors.black87),),
                                    const SizedBox(width: 5,),
                                    Icon(
                                      Icons.video_collection_rounded,
                                      color: AppColor.primaryColor1,
                                      size: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(child:
                          controller.thumbnail.value.path != '' ?
                            Image.file(controller.thumbnail.value, height: 200, fit: BoxFit.cover,)
                          :
                            controller.thumnailLink.value != "" ?
                              Image.network(controller.thumnailLink.value, height: 200, fit: BoxFit.cover,)
                            :
                              Container(height: 200, decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54, width: 1)
                                )
                              )
                        ),
                      ],
                    ),
                  ],
                ),
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
                                  if(controller.thumbnail != null){
                                    onTap();
                                  }
                                  else{
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Warning"),
                                          content: Text("Thumbnail is requires!"),
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
                                  }
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