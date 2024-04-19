
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:cloudinary_flutter/video/cld_video_controller.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';


class VideoPreview extends StatefulWidget{

  final String videoUrl;

  const VideoPreview({super.key, required this.videoUrl});


  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController  videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  bool isPlaying = false;
  @override
  void initState() {

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    videoPlayerController.addListener(() {
      if(videoPlayerController.value.position == videoPlayerController.value.duration) {
        setState(() {
          isPlaying = false;
        });
      }
    });
    initializeVideoPlayerFuture = videoPlayerController.initialize().then((_)
    {
      setState(() {
        isPlaying = true;
      });
      videoPlayerController.play();
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    videoPlayerController.dispose();

    super.dispose();
  }

  String toTimeFormat(int snds) {
    int hours   = (snds / 3600).floor();
    int minutes = ((snds - (hours * 3600)) / 60).floor();
    int seconds = snds - (hours * 3600) - (minutes * 60);
    return '$minutes:0$seconds';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12.withOpacity(0),
        title: const Text("Video instruction"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  child: Container(
                    color: Colors.grey,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FutureBuilder(
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
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(videoPlayerController.value.isPlaying){
                                setState(() {
                                  isPlaying = false;
                                });
                                videoPlayerController.pause();
                              }
                              else{
                                setState(() {
                                  isPlaying = true;
                                });
                                videoPlayerController.play();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 24,
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: videoPlayerController,
                            builder: (context, VideoPlayerValue value, child) {
                              //Do Something with the value.
                              return Text("${toTimeFormat(value.position.inSeconds)}/${toTimeFormat(value.duration.inSeconds)}", style: const TextStyle(fontSize: 16),);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: ValueListenableBuilder(
                      //       valueListenable: videoPlayerController,
                      //       builder: (context, VideoPlayerValue value, child) {
                      //         //Do Something with the value.
                      //         return LinearPercentIndicator(
                      //           width: MediaQuery.of(context).size.width,
                      //           lineHeight: 6.0,
                      //           padding: const EdgeInsets.all(0),
                      //           percent: value.position.inSeconds / value.duration.inSeconds,
                      //           backgroundColor: Colors.grey,
                      //           progressColor: AppColor.OutlineButtonColor,
                      //         );
                      //       },
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}