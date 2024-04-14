import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/admin/sign_in_admin/sign_in_binding.dart';
import 'package:do_an_2/views/admin/sign_in_admin/sign_in_page.dart';
import 'package:do_an_2/views/intro/intro_binding.dart';
import 'package:do_an_2/views/intro/intro_page.dart';
import 'package:do_an_2/views/user/application_user/application_binding.dart';
import 'package:do_an_2/views/user/application_user/application_page.dart';
import 'package:do_an_2/views/user/diary/diary_binding.dart';
import 'package:do_an_2/views/user/diary/diary_page.dart';
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
import 'package:do_an_2/views/user/workout/routine/add_routine_page.dart';
import 'package:do_an_2/views/user/workout/routine/routine_binding.dart';
import 'package:do_an_2/views/user/workout/routine/routine_page.dart';
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
      name: AppRoutes.ROUTINE,
      page: () => RoutinePage(),
      binding: RoutineBinding(),
      transition: Transition.native,
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.ADD_ROUTINE,
      page: () => AddRoutinePage(),
      binding: RoutineBinding(),
      transition: Transition.native,
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
