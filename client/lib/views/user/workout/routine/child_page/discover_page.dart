import 'package:do_an_2/views/user/workout/routine/routine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DiscoverPage extends GetView<RoutineController> {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        Text("Discover page" + controller.a.value),
      ],
    ));
  }
}