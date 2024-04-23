import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/values/color_extension.dart';

class DiaryPage extends GetView<DiaryController> {
  const DiaryPage({super.key});
  Widget _datePicker() {
    return DatePicker(
      DateTime.now().subtract(const Duration(days: 5)),
      width: 65.w,
      height: 90.h,
      daysCount: 10,
      initialSelectedDate: DateTime.now(),
      selectionColor: AppColor.primaryColor1,
      onDateChange: (selectedDate) {
        controller.onDateChange(selectedDate);
      },
      locale: "en_US",
      dayTextStyle: const TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dial Journey",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_left_rounded)),
                const Text("APR 16"),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_right_rounded)),
              ],
            ),
            _datePicker(),
            const SizedBox(height: 10),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            // calories remaining
            Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Padding(
                padding:EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Calories Remaining",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("1500", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
                            Text("Goal", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        ),
                        Text("-", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("2500", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
                            Text("Food", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        ),
                        Text("+", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("200", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
                            Text("Exercise", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        ),
                        Text("=", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("-800", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),),
                            Text("Remaining", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                            ),
              ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),

            // breakfast
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: AppColor.primaryColor1.withOpacity(0.2),
                    ),
                    child:  Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 30.h,
                                child: Image.asset("assets/images/avocado.png", ),
                              ),
                              const SizedBox(width: 20,),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Breakfast",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                                  ),
                                  Text("Energy for day!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                                ],
                              ),
                              const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("200 cal", ),
                                    ],
                                  )
                              )
                            ],),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2*70,
                    //MediaQuery.of(context).size.width-50
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.transparent,
                                        border:  Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5))
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(  "Ngu Coc Yen mach", style: TextStyle(fontSize: 16, color: Colors.black),),
                                            Text("100 cal, 1 cups" , style: TextStyle(color: Colors.black54),)
                                          ],
                                        ),
                                        Text(  "100 cal", style: TextStyle( color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text("ADD FOOD", style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20,),


            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: AppColor.primaryColor1.withOpacity(0.2),
                    ),
                    child:  Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 30.h,
                                child: Image.asset("assets/images/meal.png", ),
                              ),
                              const SizedBox(width: 20,),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lunch",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                                  ),
                                  Text("Fuel for the rest!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                                ],
                              ),
                              const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("200 cal", ),
                                    ],
                                  )
                              )
                            ],),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2*70,
                    //MediaQuery.of(context).size.width-50
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.transparent,
                                        border:  Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5))
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(  "Xuc xich chien", style: TextStyle(fontSize: 16, color: Colors.black),),
                                            Text("100 cal, 1 cups" , style: TextStyle(color: Colors.black54),)
                                          ],
                                        ),
                                        Text(  "100 cal", style: TextStyle( color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text("ADD FOOD", style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20,),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: AppColor.primaryColor1.withOpacity(0.2),
                    ),
                    child:  Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 30.h,
                                child: Image.asset("assets/images/dinner.png", ),
                              ),
                              const SizedBox(width: 20,),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dinner",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                                  ),
                                  Text("Reward in the end of day!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                                ],
                              ),
                              const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("200 cal", ),
                                    ],
                                  )
                              )
                            ],),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2*70,
                    //MediaQuery.of(context).size.width-50
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.transparent,
                                        border:  Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5))
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(  "Pho bo", style: TextStyle(fontSize: 16, color: Colors.black),),
                                            Text("100 cal, 1 serving" , style: TextStyle(color: Colors.black54),)
                                          ],
                                        ),
                                        Text(  "100 cal", style: TextStyle( color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text("ADD FOOD", style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20,),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: AppColor.primaryColor1.withOpacity(0.2),
                    ),
                    child:  Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 30.h,
                                child: Image.asset("assets/images/snack.png", ),
                              ),
                              const SizedBox(width: 20,),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Snack",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                                  ),
                                  Text("Little bit free time?", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                                ],
                              ),
                              const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("100 cal", ),
                                    ],
                                  )
                              )
                            ],),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1*70,
                    //MediaQuery.of(context).size.width-50
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.transparent,
                                        border:  Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5))
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(  "Snack potato", style: TextStyle(fontSize: 16, color: Colors.black),),
                                            Text("100 cal, 1 cups" , style: TextStyle(color: Colors.black54),)
                                          ],
                                        ),
                                        Text(  "100 cal", style: TextStyle( color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text("ADD FOOD", style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20,),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: AppColor.primaryColor1.withOpacity(0.2),
                    ),
                    child:  Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 30.h,
                                child: Image.asset("assets/images/exercise.png", ),
                              ),
                              const SizedBox(width: 20,),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Exercise",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                                  ),
                                  Text("Moving around a little bit?", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                                ],
                              ),
                              const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("200 cal", ),
                                    ],
                                  )
                              )
                            ],),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2*70,
                    //MediaQuery.of(context).size.width-50
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.transparent,
                                        border:  Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5))
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(  "Running", style: TextStyle(fontSize: 16, color: Colors.black),),
                                            Text("30 mins" , style: TextStyle(color: Colors.black54),)
                                          ],
                                        ),
                                        Text(  "100 cal", style: TextStyle( color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text("ADD EXERCISE", style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20,),


            // WATER
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      color: AppColor.primaryColor1.withOpacity(0.2),
                    ),
                    child:  Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 30.h,
                                child: Image.asset("assets/images/water.png", ),
                              ),
                              const SizedBox(width: 20,),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Water",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                                  ),
                                  Text("Something necessary with us", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                                ],
                              ),
                              const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("2 litters", ),
                                    ],
                                  )
                              )
                            ],),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2*70,
                    //MediaQuery.of(context).size.width-50
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.transparent,
                                        border:  Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5))
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(  "Water", style: TextStyle(fontSize: 16, color: Colors.black),),
                                            Text("500 ml" , style: TextStyle(color: Colors.black54),)
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text("ADD WATER", style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20,)


          ],
        ),
      ),
    );
  }
}
