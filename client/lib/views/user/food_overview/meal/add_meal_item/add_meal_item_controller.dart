import 'package:do_an_2/views/user/food_overview/food_overview_controller.dart';
import 'package:get/get.dart';

class AddMealItemController extends GetxController{
  RxList myFood = [].obs;
  RxList myRecipe = [].obs;
  RxList myMeal = [].obs;
  RxList his = [].obs;
  @override
  void onInit() {
    super.onInit();

    FoodOverviewController f = Get.find<FoodOverviewController>();
    his.value = f.his;
    myRecipe.value = f.myRecipe;
    myFood.value= f.myFood;
    myMeal.value = f.myMeal;
    update();
  }
}