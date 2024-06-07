import 'package:do_an_2/model/planDTO.dart';
import 'package:flutter/material.dart';


class SchedulePage extends StatelessWidget{
  SchedulePage(this.planDTO);
  final PlanDTO planDTO;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: planDTO.weekDescription!.length,
            itemBuilder: (BuildContext ct, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  Text("Week ${index + 1}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                  const SizedBox(height: 5,),
                  Text(planDTO.weekDescription![index], style: const TextStyle(fontSize: 16),),
                ],
              );
            },
          ),
          Container(height: 80,)
        ],
      ),
    );
  }
}