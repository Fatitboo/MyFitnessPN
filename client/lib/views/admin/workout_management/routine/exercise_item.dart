import 'package:do_an_2/model/exerciseDTO.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExerciseItem extends StatefulWidget{

  final RoutineController controller;
  final int index;


  const ExerciseItem({super.key, required this.controller, required this.index});

  @override
  State<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  late VideoPlayerController videoPlayerController;

  late Future<void> initializeVideoPlayerFuture;

  bool isPlaying = false;
  @override
  void initState() {
    if(widget.controller.listExercises[widget.index].video != null){
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.controller.listExercises[widget.index].video));
      initializeVideoPlayerFuture = videoPlayerController.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            // child: Image.asset("/assets/icons/dumbbell.png")
            child: Center(
                child:
                widget.controller.listExercises[widget.index].video == null ?
                 Text("IO"): AspectRatio(
                   aspectRatio: videoPlayerController.value.aspectRatio,
                   // aspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height - 100),
                   // Use the VideoPlayer widget to display the video.
                   child: VideoPlayer(videoPlayerController),
                 ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.controller.textEditExercise[widget.index]["name"].text!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(widget.controller.textEditExercise[widget.index]["instruction"].text ?? "", style: const TextStyle(fontSize: 16,),),
                const SizedBox(height: 5,),
                if(widget.controller.textEditExercise[widget.index]["type"].text == "strength")
                  for(int i = 0 ; i < widget.controller.textEditExercise[widget.index]["sets"]!.length; i++)
                    Row(
                      children: [
                        SizedBox(width: 20, child: Text("${i + 1}")),
                        SizedBox(width: 80,child: Text("weight: ${widget.controller.textEditExercise[widget.index]["sets"]![i]["weight"].text}")),
                        const SizedBox(width: 5,),
                        Text("rep: ${widget.controller.textEditExercise[widget.index]["sets"]![i]["rep"].text}"),
                      ],
                    )
                else
                  Text("Duration: ${widget.controller.textEditExercise[widget.index]["minutes"].text}")
              ],
            ),
          )
        ],
      ),
    );
  }
}