import 'package:do_an_2/model/foodDTO.dart';
import 'package:do_an_2/model/mealDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';
class LogFoodItemDTO {
  FoodDTO? food;
  RecipeDTO? recipe;
  MealDTO? meal;
  double? numberOfServing;
  String? foodLogType;

  LogFoodItemDTO(this.food, this.recipe,  this.meal, this.numberOfServing, this.foodLogType);

  factory LogFoodItemDTO.fromJson(Map<String, dynamic> json) {
    LogFoodItemDTO item = LogFoodItemDTO(
      json["food"] != null ?  FoodDTO.fromJson(json["food"]) : null,
      json["recipe"] != null ?  RecipeDTO.fromJson(json["recipe"]) : null,
      json["meal"] != null ?  MealDTO.fromJson(json["meal"]) : null,
      json["numberOfServing"] ?? 0 as double,
      json["foodLogType"] ?? "",
      );

      return item;
  }

  Map<String, dynamic> toJson() => {
    "food": food?.toJson(),
    "recipe": recipe?.toJson(),
    "meal": meal?.toJson(),
    "numberOfServing": numberOfServing,
    "foodLogType":foodLogType
  };

  double getCaloriesPerItem(){
    double tt =0;
    if(foodLogType=="food"){
      tt += food!.getCals();
    }
    if(foodLogType=="recipe"){
      tt += recipe!.getCalories();
    }
    if(foodLogType=="meal"){
      tt += meal!.getCals();
    }
    return tt*numberOfServing!;
  }

}