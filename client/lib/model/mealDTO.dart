import 'package:do_an_2/model/foodDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';
class MealDTO {
  String? mealId;
  String? description;
  String? photo;
  double? numberOfServing;
  List<FoodDTO>? foods;
  List<RecipeDTO>? recipes;
  String? direction;

  MealDTO(this.mealId, this.description,this.photo,  this.numberOfServing, this.foods, this.recipes, this.direction);

  factory MealDTO.fromJson(Map<String, dynamic> json) {
    MealDTO item = MealDTO(
        json["mealId"] ?? "",
        json["description"] ?? "",
        json["photo"] ?? "",
        json["numberOfServing"] ?? 0 as double,
        json["foods"] != null ? (json["foods"] as List).map((e) => FoodDTO.fromJson(e)).toList() : [],
        json["recipes"] != null ? (json["recipes"] as List).map((e) => RecipeDTO.fromJson(e)).toList() : [],
        json["direction"] ?? ""

      );

      return item;
  }
  Map<String, dynamic> toJson() => {
    "mealId": mealId,
    "description": description,
    "photo": photo,
    "numberOfServing": numberOfServing,
    "foods": foods == null? []: List<dynamic>.from(foods!.map((x) => x.toJson())),
    "recipes": recipes == null? []: List<dynamic>.from(recipes!.map((x) => x.toJson())),
    "direction": direction,
  };
  String getStringDescription(){
    double tt = 0;
    for(FoodDTO f in foods!){
      tt+= f.nutrition!.first.amount;
    }
    for(RecipeDTO r in recipes!){
      for(FoodDTO c in r.foods!){
        tt+=((c.nutrition?.first.amount)!*(c.numberOfServing??1)
            *(c.servingSize??100)/100)*(r.numberOfServing??1);
      }
    }
    return "$tt cal, $numberOfServing cups";

  }

}