
import 'package:do_an_2/views/admin/application_admin/application_controller.dart';
import 'package:do_an_2/views/admin/blog_management/blog_management_controller.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/discover_recipes_controller.dart';
import 'package:do_an_2/views/admin/meal_management/meal_management_controller.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:do_an_2/views/admin/plan_management/plan_management_controller.dart';
import 'package:do_an_2/views/admin/profile_admin/profile_admin_controller.dart';
import 'package:do_an_2/views/admin/workout_management/exercise/exercise_controller.dart';
import 'package:do_an_2/views/admin/workout_management/routine/routine_controller.dart';
import 'package:do_an_2/views/admin/workout_management/workout_management_controller.dart';
import 'package:get/get.dart';

class ApplicationAdminBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut<ApplicationAdminController>(() => ApplicationAdminController());
      Get.lazyPut<BlogManagementController>(() => BlogManagementController());
      Get.lazyPut<MealManagementController>(() => MealManagementController());
      Get.lazyPut<WorkoutManagementController>(() => WorkoutManagementController());
      Get.lazyPut<ProfileAdminController>(() => ProfileAdminController());
      Get.lazyPut<PlanManagementController>(() => PlanManagementController());
      Get.lazyPut<ExerciseController>(() => ExerciseController());
      Get.lazyPut<RoutineController>(() => RoutineController());
      Get.lazyPut<DiscoverRecipesController>(() => DiscoverRecipesController());
      Get.lazyPut<PlanAdminController>(() => PlanAdminController());
  }
  
}