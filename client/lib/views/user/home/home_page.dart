import 'package:do_an_2/res/values/color_extension.dart';
import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../../res/widgets/round_button.dart';

class HomePage extends GetView<HomeController> {


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor:  AppColor.primaryColor1,
        leading: Image.asset(
          'assets/images/food.png',
          width: 80,
        ),
        title: Text("MyFitnessPN" + controller.a.value, style: TextStyle(color: Colors.white),),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: AppColor.primaryColor1,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                    height: media.width * 0.55,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: AppColor.primaryG),
                        borderRadius:
                            BorderRadius.circular(media.width * 0.05)),
                    child: Stack(alignment: Alignment.center, children: [
                      Image.asset(
                        "assets/images/bg_dots.png",
                        height: media.width * 0.55,
                        width: double.maxFinite,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(
                        height: media.width * 0.55,
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Calories",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Remaining = Goal - Food + Exercise",
                                style: TextStyle(
                                    color: AppColor.black, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AspectRatio(
                                        aspectRatio: 16 / 12,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            width: media.width * 0.4,
                                            height: media.width * 0.4,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: media.width * 0.4,
                                                  height: media.width * 0.4,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            media.width * 0.1),
                                                  ),
                                                  child: FittedBox(
                                                    child: Text(
                                                      "230kCal\nRemaining",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: AppColor.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                                SimpleCircularProgressBar(
                                                  size: 120,
                                                  progressStrokeWidth: 12,
                                                  backStrokeWidth: 10,
                                                  progressColors:
                                                      AppColor.secondaryG,
                                                  backColor:
                                                      Colors.grey.shade100,
                                                  valueNotifier:
                                                      ValueNotifier(75),
                                                  startAngle: -180,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              height: 30,
                                              child: Image.asset(
                                                "assets/icons/flag.png",
                                                fit: BoxFit.fitHeight,
                                                color: AppColor.gray,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Base Goal",
                                                  style: TextStyle(
                                                      color: AppColor.black,
                                                      fontSize: 12),
                                                ),
                                                const Text(
                                                  "1500",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              height: 30,
                                              child: Image.asset(
                                                "assets/icons/spoonf.png",
                                                fit: BoxFit.fitHeight,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Food",
                                                  style: TextStyle(
                                                      color: AppColor.black,
                                                      fontSize: 12),
                                                ),
                                                const Text(
                                                  "500",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              height: 30,
                                              child: Image.asset(
                                                "assets/icons/fire.png",
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Exercise",
                                                  style: TextStyle(
                                                      color: AppColor.black,
                                                      fontSize: 12),
                                                ),
                                                const Text(
                                                  "100",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ])),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: media.width * 0.88,
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 2)
                          ]),
                      child: Row(
                        children: [
                          SimpleAnimationProgressBar(
                            height: media.width * 0.85,
                            width: media.width * 0.07,
                            backgroundColor: Colors.grey.shade100,
                            foregrondColor: Colors.purple,
                            ratio: 0.5,
                            direction: Axis.vertical,
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(seconds: 3),
                            borderRadius: BorderRadius.circular(15),
                            gradientColor: LinearGradient(
                                colors: AppColor.primaryG,
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Goal",
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 12,
                                  ),
                                ),
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) {
                                    return LinearGradient(
                                            colors: AppColor.primaryG,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)
                                        .createShader(Rect.fromLTRB(
                                            0, 0, bounds.width, bounds.height));
                                  },
                                  child: Text(
                                    "4 Liters",
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "Water updates",
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 12,
                                  ),
                                ),
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) {
                                    return LinearGradient(
                                            colors: AppColor.primaryG,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)
                                        .createShader(Rect.fromLTRB(
                                            0, 0, bounds.width, bounds.height));
                                  },
                                  child: Text(
                                    "1.4 Liters",
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Row(children: [
                                    SizedBox(
                                      height: 20,
                                      child: Image.asset(
                                        "assets/icons/addwater.png",
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Text(
                                      "Add water",
                                      style: TextStyle(
                                        color: AppColor.black,
                                        fontSize: 12,
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                    SizedBox(
                      width: media.width * 0.05,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: double.maxFinite,
                            height: media.width * 0.41,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(

                                // gradient: LinearGradient(colors: [AppColor.secondaryColor2,AppColor.lightSecondaryColor2, ]),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 4)
                                ],
                            color: AppColor.white),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "BMI (Body Mass Index)",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "20.1",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 60,
                                  height: 35,
                                  child: Image.asset(
                                    "assets/images/bmi.png",
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "You have a normal weight",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        Container(
                            width: double.maxFinite,
                            height: media.width * 0.41,
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                                // gradient: LinearGradient(colors: AppColor.blueLinear),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 4)
                                ]),
                            child: Column(
                              children: [
                                Text(
                                  "Current weight",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "70Kg",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 120,
                                    height: 35,
                                    child: RoundButton(
                                        title: "Update weight",
                                        type: RoundButtonType.bgSGradient,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        onPressed: () {}))
                              ],
                            ))
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
