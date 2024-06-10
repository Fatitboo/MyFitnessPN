import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

import '../../../../../res/values/color_extension.dart';
import '../../../../../res/widgets/my_button.dart';

class SecondPage extends GetView<RoutineController>{
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
                height: MediaQuery.of(context).size.height + 500,
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
                            const Text("Video Intro", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                          : Container(height: 200, decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54, width: 1)
                            )
                          )
                        ),
                      ],
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
                              hintText: 'Video',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.pickVideo();
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
                    controller.isVisibleVideo.value ?
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            border: Border.all(color: Colors.black87)
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Align(
                              child: SizedBox(
                                height: 450,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: AspectRatio(
                                        aspectRatio: controller.videoPlayerController.value.aspectRatio,
                                        // Use the VideoPlayer widget to display the video.
                                        child: VideoPlayer(controller.videoPlayerController),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if(controller.videoPlayerController.value.isPlaying){
                                          controller.videoPlayerController.pause();
                                          controller.isPlayVideo.value = false;
                                        }
                                        else{
                                          controller.videoPlayerController.play();
                                          controller.isPlayVideo.value = true;
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(
                                          controller.isPlayVideo.value ? Icons.pause : Icons.play_arrow,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: controller.videoPlayerController,
                                      builder: (context, VideoPlayerValue value, child) {
                                        //Do Something with the value.
                                        return Text("${controller.toTimeFormat(value.position.inSeconds)}/${controller.toTimeFormat(value.duration.inSeconds)}", style: const TextStyle(fontSize: 16),);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if(controller.isVisibleVideo.value)
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ValueListenableBuilder(
                                      valueListenable: controller.videoPlayerController,
                                      builder: (context, VideoPlayerValue value, child) {
                                        //Do Something with the value.
                                        return LinearPercentIndicator(
                                          width: MediaQuery.of(context).size.width - 42,
                                          lineHeight: 6.0,
                                          padding: const EdgeInsets.all(0),
                                          percent: value.position.inSeconds / value.duration.inSeconds,
                                          backgroundColor: Colors.grey,
                                          progressColor: AppColor.OutlineButtonColor,
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),

                          ],
                        ),
                      ): Container(
                      height: 450,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54)
                      ),)
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
                                  onTap();
                                  return;
                                  if(controller.thumbnail != null){
                                    if(controller.video != null){
                                      onTap();
                                    }
                                    else{
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          AlertDialog alert = AlertDialog(
                                            title: Text("Warning"),
                                            content: Text("Video instruction is requires!"),
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