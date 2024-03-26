import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController>{
  @override
  Widget build(BuildContext context) {
   return const Center(
     child: Text('Home page'),
   );
  }

}