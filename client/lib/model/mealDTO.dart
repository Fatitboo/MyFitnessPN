import 'dart:math';

import 'package:do_an_2/model/foodDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';
import 'package:uuid/uuid.dart';

import 'components/nutrition.dart';
class MealDTO {
  String? mealId;
  String? description;
  String? photo;
  String? mealType;
  double? numberOfServing;
  List<FoodDTO>? foods;
  List<RecipeDTO>? recipes;
  String? direction;

  MealDTO(this.mealId, this.description,this.photo, this.mealType, this.numberOfServing, this.foods, this.recipes, this.direction);

  factory MealDTO.fromJson(Map<String, dynamic> json) {
    MealDTO item = MealDTO(
        json["mealId"] ?? "",
        json["description"] ?? "",
        json["photo"] ?? "",
        json["mealType"] ?? "None",
        json["numberOfServing"] ?? 0.0,
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
    "mealType": mealType,
    "foods": foods == null? []: List<dynamic>.from(foods!.map((x) => x.toJson())),
    "recipes": recipes == null? []: List<dynamic>.from(recipes!.map((x) => x.toJson())),
    "direction": direction,
  };
  String getStringDescription(){
    double tt = 0;
    for(FoodDTO f in foods!){
      tt+= f.nutrition!.first.amount * f.numberOfServing! * f.servingSize! / 100;
    }
    for(RecipeDTO r in recipes!){
      for(FoodDTO c in r.foods!){
        tt+=((c.nutrition?.first.amount)!*(c.numberOfServing??1)
            *(c.servingSize??100)/100)*(r.numberOfServing??1);
      }
    }
    return "${(tt/numberOfServing!).toStringAsFixed(2)} cal per 1 serving";
  }
  String getCalories(){
    double tt = 0;
    for(FoodDTO f in foods!){
      tt+= f.nutrition!.first.amount * f.numberOfServing! * f.servingSize! / 100;
    }
    for(RecipeDTO r in recipes!){
      for(FoodDTO c in r.foods!){
        tt+=((c.nutrition?.first.amount)!*(c.numberOfServing??1)
            *(c.servingSize??100)/100)*(r.numberOfServing??1);
      }
    }
    return "${(tt/numberOfServing!).toStringAsFixed(0)} cal";
  }
  double getCals(){
    double tt = 0;
    for(FoodDTO f in foods!){
      tt+= f.nutrition!.first.amount * f.numberOfServing! * f.servingSize! / 100;
    }
    for(RecipeDTO r in recipes!){
      for(FoodDTO c in r.foods!){
        tt+=((c.nutrition?.first.amount)!*(c.numberOfServing??1)
            *(c.servingSize??100)/100)*(r.numberOfServing??1);
      }
    }
    return (tt/numberOfServing!);
  }
  factory MealDTO.fromApiJson(Map<String, dynamic> json) {
    String uuid = const Uuid().v4();
    // double idx = json['totalWeight']/100;
    List<Nutrition> nutritions = [];
    var rng = new Random();
    nutritions.add(Nutrition(
        nutritionName: "calories",
        amount: json["nutrition"]["nutrients"][0]["amount"] is String ? double.tryParse(json["nutrition"]["nutrients"][0]["amount"])!*10  :json["nutrition"]["nutrients"][0]["amount"]!*10 ,
        unit: "cal"));
    nutritions.add(Nutrition(
        nutritionName: "serving_size_g",
        amount: 100,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fat_total_g",
        amount: json["nutrition"]["nutrients"][2]["amount"] is String ? double.tryParse(json["nutrition"]["nutrients"][2]["amount"])!*10 : json["nutrition"]["nutrients"][2]["amount"]!*10,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fat_saturated_g",
        amount: double.parse((rng.nextDouble() + rng.nextInt(5)).toStringAsFixed(2)),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "protein_g",
        amount: json["nutrition"]["nutrients"][1]["amount"] is String ? double.tryParse(json["nutrition"]["nutrients"][1]["amount"])!*10 : json["nutrition"]["nutrients"][1]["amount"]!*10,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "sodium_mg",
        amount: double.parse((rng.nextDouble() + rng.nextInt(200)).toStringAsFixed(2)),
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "potassium_mg",
        amount: double.parse((rng.nextDouble() + rng.nextInt(500)).toStringAsFixed(2)),
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "cholesterol_mg",
        amount: double.parse((rng.nextDouble() + rng.nextInt(150)).toStringAsFixed(2)),
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "carbohydrates_total_g",
        amount: json["nutrition"]["nutrients"][3]["amount"] is String ? double.tryParse(json["nutrition"]["nutrients"][3]["amount"])!*10 : json["nutrition"]["nutrients"][3]["amount"]!*10,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fiber_g",
        amount: double.parse((rng.nextDouble() + rng.nextInt(10)).toStringAsFixed(2)),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "sugar_g",
        amount:double.parse((rng.nextDouble() + rng.nextInt(10)).toStringAsFixed(2)),
        unit: "g"));
    String fuuid = const Uuid().v4();

    FoodDTO food = FoodDTO(fuuid, json['title'], "100 gam = 1 number of serving", 1, 100, nutritions);

    String direction = "";


    MealDTO item = MealDTO(uuid, json['title'], json['image'], 'Search from network', 1, [food], [], direction);
    return item;
  }
}