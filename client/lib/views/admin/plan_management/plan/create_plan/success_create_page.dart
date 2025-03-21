import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/res/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class SuccessCreatePage extends StatelessWidget{
  const SuccessCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Navigate"),

        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/check_mark.png',height: 200, width: 200,),
              const SizedBox(height: 10,),
              const Text('Successfully!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black54),),
              const SizedBox(height: 60,),
              const Text('Do you want to add tasks to this plan now?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),),
              const SizedBox(height: 5,),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          child: MyButton(
                            onTap: () {
                              Get.offNamed(AppRoutes.PLAN_MANAGEMENT_ADD);
                              Get.back();
                            },
                            bgColor: AppColor.white,
                            textString: 'Maybe Later',
                            textColor: AppColor.blackText,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            children: [
                              MyButton(
                                onTap: () {

                                },
                                bgColor: AppColor.blackText,
                                textString: 'Continue',
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
            ],
          ),
        ),
      ),
    );
  }

}