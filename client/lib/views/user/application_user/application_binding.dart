import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:do_an_2/views/user/application_user/application_controller.dart';
import 'package:do_an_2/views/user/diary/diary_controller.dart';
import 'package:do_an_2/views/user/home/home_controller.dart';
import 'package:do_an_2/views/user/plan/plan_controller.dart';
import 'package:do_an_2/views/user/profile/profile_controller.dart';
import 'package:get/get.dart';

class ApplicationUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiaryController>(() => DiaryController());
    Get.lazyPut<ApplicationUserController>(() => ApplicationUserController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PlanAdminController>(() => PlanAdminController());
    Get.lazyPut<PlanController>(() => PlanController());
    Get.lazyPut<ProfileController>(() => ProfileController());

  }
}