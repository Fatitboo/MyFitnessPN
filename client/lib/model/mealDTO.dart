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
      tt+= f.nutrition!.first.amount;
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
    double idx = json['totalWeight']/100;
    List<Nutrition> nutritions = [];
    nutritions.add(Nutrition(
        nutritionName: "calories",
        amount: json["calories"] is String ? double.tryParse(json["calories"])!/idx  : json["calories"]?.toDouble()/idx,
        unit: "cal"));
    nutritions.add(Nutrition(
        nutritionName: "serving_size_g",
        amount: 100,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fat_total_g",
        amount: json["totalNutrients"]['FAT']['quantity'] is String ? double.tryParse(json["totalNutrients"]['FAT']['quantity'])!/idx : json["totalNutrients"]['FAT']['quantity']/idx,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fat_saturated_g",
        amount: json["totalNutrients"]['FASAT']['quantity'] is String ? double.tryParse(json["totalNutrients"]['FASAT']['quantity'])!/idx : json["totalNutrients"]['FASAT']['quantity']/idx,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "protein_g",
        amount: json["totalNutrients"]['PROCNT']['quantity'] is String ? double.tryParse(json["totalNutrients"]['PROCNT']['quantity'])!/idx : json["totalNutrients"]['PROCNT']['quantity']/idx,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "sodium_mg",
        amount: json["totalNutrients"]['NA']['quantity'] is String ? double.tryParse(json["totalNutrients"]['NA']['quantity'])!/idx : json["totalNutrients"]['NA']['quantity']/idx,
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "potassium_mg",
        amount: json["totalNutrients"]['K']['quantity'] is String ? double.tryParse(json["totalNutrients"]['K']['quantity'])!/idx : json["totalNutrients"]['K']['quantity']/idx,
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "cholesterol_mg",
        amount: json["totalNutrients"]['CHOLE']['quantity'] is String ? double.tryParse(json["totalNutrients"]['CHOLE']['quantity'])!/idx : json["totalNutrients"]['CHOLE']['quantity']/idx,
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "carbohydrates_total_g",
        amount: json["totalNutrients"]['CHOCDF']['quantity'] is String ? double.tryParse(json["totalNutrients"]['CHOCDF']['quantity'])!/idx : json["totalNutrients"]['CHOCDF']['quantity']/idx,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fiber_g",
        amount: json["totalNutrients"]['FIBTG']['quantity'] is String
            ? double.tryParse(json["totalNutrients"]['FIBTG']['quantity'])!/idx
            : json["totalNutrients"]['FIBTG']['quantity']/idx,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "sugar_g",
        amount:json["totalNutrients"]['SUGAR']['quantity'] is String ? double.tryParse(json["totalNutrients"]['SUGAR']['quantity'])!/idx : json["totalNutrients"]['SUGAR']['quantity']/idx,
        unit: "g"));
    String fuuid = const Uuid().v4();

    FoodDTO food = FoodDTO(fuuid, json['label'], "100 gam = 1 number of serving", 1, 100, nutritions);

    String direction = "";

    for(var igr in json['ingredientLines']){
      direction+=" Add $igr";
    }
    MealDTO item = MealDTO(uuid, json['label'], json['image'], json['mealType'][0], 1, [food], [], direction);
    return item;
  }
}