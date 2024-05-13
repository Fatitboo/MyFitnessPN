import 'package:do_an_2/res/routes/names.dart';
import 'package:do_an_2/views/admin/application_admin/application_binding.dart';
import 'package:do_an_2/views/admin/application_admin/application_page.dart';
import 'package:do_an_2/views/admin/blog_management/blog_management_binding.dart';
import 'package:do_an_2/views/admin/blog_management/blog_management_page.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/add_discover_recipe/add_discover_recipe_binding.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/add_discover_recipe/add_discover_recipe_page.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/add_discover_recipe/ingredients/search_ingredient_page.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/discover_recipes_binding.dart';
import 'package:do_an_2/views/admin/meal_management/discover_recipes/discover_recipes_page.dart';
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
import 'package:do_an_2/views/user/food_overview/add_food/add_food_binding.dart';
import 'package:do_an_2/views/user/food_overview/add_food/add_food_controller.dart';
import 'package:do_an_2/views/user/food_overview/add_food/add_food_page.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_binding.dart';
import 'package:do_an_2/views/user/food_overview/food_overview_page.dart';
import 'package:do_an_2/views/user/food_overview/log_food/log_food_binding.dart';
import 'package:do_an_2/views/user/food_overview/log_food/log_food_page.dart';
import 'package:do_an_2/views/user/food_overview/meal/add_meal_item/add_meal_item_binding.dart';
import 'package:do_an_2/views/user/food_overview/meal/meal_binding.dart';
import 'package:do_an_2/views/user/food_overview/meal/meal_page.dart';
import 'package:do_an_2/views/user/food_overview/page/add_water.dart';
import 'package:do_an_2/views/user/food_overview/page/quick_add_page.dart';
import 'package:do_an_2/views/user/food_overview/recipe/add_recipe_binding.dart';
import 'package:do_an_2/views/user/food_overview/recipe/add_recipe_page.dart';
import 'package:do_an_2/views/user/food_overview/recipe/ingredients/search_ingredient_page.dart';
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

import '../../views/user/food_overview/meal/add_meal_item/add_meal_item_page.dart';
import '../../views/user/workout/exercise/exercise_page.dart';
import '../../views/user/workout/routine/add_routine_page.dart';
import '../../views/user/workout/routine/routine_binding.dart';
import '../../views/user/workout/routine/routine_page.dart';

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
      name: AppRoutes.QUICK_ADD,
      page: () => QuickAddPage(),
      binding: AddFoodBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.ADD_WATER,
      page: () => LogWaterPage(),
      binding: AddFoodBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.ADD_FOOD,
      page: () => AddFoodPage(),
      binding: AddFoodBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.LOG_FOOD,
      page: () => LogFoodPage(),
      binding: LogFoodBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.ADD_RECIPE,
      page: () => AddRecipePage(),
      binding: AddRecipeBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.INGREDIENTS,
      page: () => SearchIngredientPage(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.MEAL_ACTION,
      page: () => MealPage(),
      binding: MealBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.ADD_MEAL_ITEM,
      page: () => AddMealItemPage(),
      binding: AddMealItemBinding(),
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
      name: AppRoutes.INGREDIENTS_ADMIN,
      page: () => SearchIngredientAdminPage(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.WORKOUT_MANAGEMENT,
      page: () => WorkoutManagementPage(),
      binding: WorkoutManagementBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.DISCOVER_RECIPES_MANAGEMENT,
      page: () => DiscoverRecipesPage(),
      binding: DiscoverRecipesBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppRoutes.DISCOVER_RECIPES_MANAGEMENT_ADD,
      page: () => AddDiscoverRecipePage(),
      binding: AddDiscoverRecipeBinding(),
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
