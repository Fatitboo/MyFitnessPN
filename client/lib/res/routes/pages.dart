import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/admin/application_admin/application_binding.dart';
import 'package:do_an_2/views/admin/application_admin/application_page.dart';
import 'package:do_an_2/views/admin/blog_management/blog_management_binding.dart';
import 'package:do_an_2/views/admin/blog_management/blog_management_page.dart';
import 'package:do_an_2/views/admin/meal_management/meal_management_binding.dart';
import 'package:do_an_2/views/admin/meal_management/meal_management_page.dart';
import 'package:do_an_2/views/admin/plan_management/plan_management_binding.dart';
import 'package:do_an_2/views/admin/plan_management/plan_management_page.dart';
import 'package:do_an_2/views/admin/profile_admin/profile_admin_binding.dart';
import 'package:do_an_2/views/admin/profile_admin/profile_admin_page.dart';
import 'package:do_an_2/views/admin/sign_in_admin/sign_in_binding.dart';
import 'package:do_an_2/views/admin/sign_in_admin/sign_in_page.dart';
import 'package:do_an_2/views/admin/workout_management/workout_management_binding.dart';
import 'package:do_an_2/views/admin/workout_management/workout_management_page.dart';
import 'package:do_an_2/views/intro/intro_binding.dart';
import 'package:do_an_2/views/intro/intro_page.dart';
import 'package:do_an_2/views/user/application_user/application_binding.dart';
import 'package:do_an_2/views/user/application_user/application_page.dart';
import 'package:do_an_2/views/user/diary/diary_binding.dart';
import 'package:do_an_2/views/user/diary/diary_page.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_binding.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_page.dart';
import 'package:do_an_2/views/user/home/home_binding.dart';
import 'package:do_an_2/views/user/home/home_page.dart';
import 'package:do_an_2/views/user/profile/profile_binding.dart';
import 'package:do_an_2/views/user/profile/profile_page.dart';
import 'package:do_an_2/views/user/sign_in/sign_in_binding.dart';
import 'package:do_an_2/views/user/sign_in/sign_in_page.dart';
import 'package:do_an_2/views/user/sign_up/sign_up_binding.dart';
import 'package:do_an_2/views/user/sign_up/sign_up_page.dart';
import 'package:do_an_2/views/user/welcome/welcome_binding.dart';
import 'package:do_an_2/views/user/welcome/welcome_page.dart';
import 'package:do_an_2/views/user/workout/exercise/exercise_binding.dart';
import 'package:get/get.dart';

import '../../views/user/workout/exercise/exercise_page.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static List<String> history = [];
  static final List<GetPage> routes = [
    // chung
    GetPage(
        name: AppRoutes.INITIAL,
        page: () => IntroPage(),
        binding: IntroBinding()),

    // user pages
    GetPage(
        name: AppRoutes.WELCOME,
        page: () => WelcomePage(),
        binding: WelcomeBinding()),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
      transition: Transition.native,
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN_USER,
      page: () => SignInPage(),
      binding: SignInBinding(),
      transition: Transition.native,
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.APPLICATION_USER,
      page: () => ApplicationUserPage(),
      binding: ApplicationUserBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.HOME_USER,
      page: () => HomePage(),
      binding: HomeBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.DIARY,
      page: () => DiaryPage(),
      binding: DiaryBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.PROFILE_USER,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.FOOD_OVERVIEW,
      page: () => FoodOverviewPage(),
      binding: FoodOverviewBinding(),
      transition: Transition.native,
    ),





    GetPage(
      name: AppRoutes.EXERCISE,
      page: () => ExercisePage(),
      binding: ExerciseBinding(),
      transition: Transition.native,
    ),

    // admin pages
    GetPage(
      name: AppRoutes.SIGN_IN_ADMIN,
      page: () => SignInAdminPage(),
      binding: SignInAdminBinding(),
      transition: Transition.native,
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.APPLICATION_ADMIN,
      page: () => ApplicationAdminPage(),
      binding: ApplicationAdminBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.PLAN_MANAGEMENT,
      page: () => PlanManagementPage(),
      binding: PlanManagementBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.MEAL_MANAGEMENT,
      page: () => MealManagementPage(),
      binding: MealManagementBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.WORKOUT_MANAGEMENT,
      page: () => WorkoutManagementPage(),
      binding: WorkoutManagementBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.BLOG_MANAGEMENT,
      page: () => BlogManagementPage(),
      binding: BlogManagementBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.PROFILE_ADMIN,
      page: () => ProfileAdminPage(),
      binding: ProfileAdminBinding(),
      transition: Transition.native,
    ),
  ];
}
