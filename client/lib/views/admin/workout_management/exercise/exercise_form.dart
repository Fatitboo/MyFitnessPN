 import 'dart:convert';
import 'dart:core';
import 'package:do_an_2/data/network/cloudinary.dart';
import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/res/values/constants.dart';
import 'package:do_an_2/views/admin/workout_management/exercise/exercise_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';
import '../../../../res/values/color_extension.dart';
import '../../../../res/widgets/loading_widget.dart';

class ExerciseForm extends GetView<ExerciseController>{

  TextEditingController name = TextEditingController();
  TextEditingController instruction = TextEditingController();
  TextEditingController type = TextEditingController();

  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  @override
  Widget build(BuildContext context) {
    String typeForm = Get.arguments["type"];
    if(typeForm == "edit"){
      name.text = controller.selected.name!;
      instruction.text = controller.selected.instruction!;
      controller.selectedType.value = "${controller.selected.type![0].toUpperCase()}${controller.selected.type!.substring(1).toLowerCase()}";

      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(controller.selected.video!));
      videoPlayerController.addListener(() {
        if(controller.videoPlayerController.value.position == videoPlayerController.value.duration) {
          controller.isPlayVideo.value = false;
        }
      });
      initializeVideoPlayerFuture = videoPlayerController.initialize().then((_)
      {
        controller.isVisibleVideo.value = true;
      });
    }
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(typeForm == "add" ? "Add Exercise" : "Edit Exercise"),
            Row(
              children: [
                LoadingWidget(loading: controller.loadingUpload.value),
                const SizedBox(width: 5,),
                InkWell(
                  onTap: () async {
                    if(name.text.toString().trim().isEmpty){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          AlertDialog alert = AlertDialog(
                            title: Text("Warning"),
                            content: Text("Name is requires!"),
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
                    controller.loadingUpload.value = true;

                    //Cập nhật
                    if(typeForm == "edit"){
                      if(controller.video != null){
                        bool isSuccess = await CloudinaryNetWork().delete(controller.selected.video!, Constant.FILE_TYPE_video);
                        if(isSuccess){
                          Map<String, dynamic> res = await CloudinaryNetWork().upload(Constant.CLOUDINARY_ADMIN_EXERICSE_VIDEO, controller.video!, Constant.FILE_TYPE_video);
                          if(res["isSuccess"]){
                            var obj = {
                              "name": name.text,
                              "type": controller.selectedType.value.toLowerCase(),
                              "instruction": instruction.text,
                              "video": res["imageUrl"]
                            };

                            if(await controller.updateExercise(ExerciseDTO.fromJson(obj), jsonEncode(obj), controller.selected.id!)){
                              Get.back();
                            }
                            else{
                              print("Lỗi hệ thống");
                            }
                          }
                          else{
                            print(res["message"]);
                          }
                        }
                        else{
                          print("System Failure");
                        }
                      }
                      else{
                        var obj = {
                          "name": name.text,
                          "type": controller.selectedType.value.toLowerCase(),
                          "instruction": instruction.text,
                          "video": controller.selected.video!
                        };

                        if(await controller.updateExercise(ExerciseDTO.fromJson(obj), jsonEncode(obj), controller.selected.id!)){
                          Get.back();
                        }
                        else{
                          print("Lỗi hệ thống");
                        }
                      }
                    }

                    //Tạo mới
                    else{
                      if(controller.video != null){
                        Map<String, dynamic> res = await CloudinaryNetWork().upload(Constant.CLOUDINARY_ADMIN_EXERICSE_VIDEO, controller.video!, Constant.FILE_TYPE_video);
                        if(res["isSuccess"]){
                          var obj = {
                            "name": name.text,
                            "type": controller.selectedType.value.toLowerCase(),
                            "instruction": instruction.text,
                            "video": res["imageUrl"]
                          };

                          if(await controller.createExercise(jsonEncode(obj))){
                            Get.back();
                          }
                          else{
                            print("Lỗi hệ thống");
                          }
                        }
                        else{
                          print(res["message"]);
                        }
                      }
                      else{
                        var obj = {
                          "name": name.text,
                          "type": controller.selectedType.value.toLowerCase(),
                          "instruction": instruction.text,
                        };

                        if(await controller.createExercise(jsonEncode(obj))){
                          Get.back();
                        }
                        else{
                          print("Lỗi hệ thống");
                        }
                      }
                    }

                    controller.loadingUpload.value = false;
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor1,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      typeForm == "edit" ? "Update" : "Add",
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: instruction,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Instruction',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 100,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type',
                      ),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        controller.selectedType.value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColor.black,
                        ),
                      ),
                      items: controller.itemsType.map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColor.black,
                          ),
                        ),
                      )).toList(),
                      value: controller.selectedType.value,
                      onChanged: (String? value) {
                        controller.onChangeValueDropdownBtn(value!);
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                        elevation: 0,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
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
                      controller.isSelectFromEdit.value = true;
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
              if(controller.isVisibleVideo.value)
                controller.isSelectFromEdit.value ?
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Align(
                      child: FutureBuilder(
                        future: controller.initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            // If the VideoPlayerController has finished initialization, use
                            // the data it provides to limit the aspect ratio of the video.
                            return AspectRatio(
                              aspectRatio: controller.videoPlayerController.value.aspectRatio,
                              // Use the VideoPlayer widget to display the video.
                              child: VideoPlayer(controller.videoPlayerController),
                            );
                          } else {
                            // If the VideoPlayerController is still initializing, show a
                            // loading spinner.
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
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
                                  width: MediaQuery.of(context).size.width - 30,
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
                ) :
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Align(
                      child: FutureBuilder(
                        future: initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            // If the VideoPlayerController has finished initialization, use
                            // the data it provides to limit the aspect ratio of the video.
                            return AspectRatio(
                              aspectRatio: videoPlayerController.value.aspectRatio,
                              // Use the VideoPlayer widget to display the video.
                              child: VideoPlayer(videoPlayerController),
                            );
                          } else {
                            // If the VideoPlayerController is still initializing, show a
                            // loading spinner.
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
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
                                if(videoPlayerController.value.isPlaying){
                                  videoPlayerController.pause();
                                  controller.isPlayVideo.value = false;
                                }
                                else{
                                  videoPlayerController.play();
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
                              valueListenable: videoPlayerController,
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
                                  width: MediaQuery.of(context).size.width - 30,
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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ));
  }



}

