import 'dart:math';

import 'package:do_an_2/model/foodDTO.dart';
import 'package:uuid/uuid.dart';

import 'components/nutrition.dart';

class RecipeDTO {
  String? recipeId;
  String? title;
  double? numberOfServing;
  List<FoodDTO>? foods;

  RecipeDTO(this.recipeId, this.title, this.numberOfServing, this.foods);

  factory RecipeDTO.fromJson(Map<String, dynamic> json) {
    RecipeDTO item = RecipeDTO(
      json["recipeId"] ?? "",
      json["title"] ?? "",
      json["numberOfServing"] ?? 0 as double,
      json["foods"] != null
          ? (json["foods"] as List).map((e) => FoodDTO.fromJson(e)).toList()
          : [],
    );

    return item;
  }
  factory RecipeDTO.fromApiJson(Map<String, dynamic> json) {
    String uuid = const Uuid().v4();
    List<Nutrition> nutritions = [];
    var rng = new Random();

    nutritions.add(Nutrition(
        nutritionName: "calories",
        amount: json["nutritional_contents"]["energy"]["value"] is String ? double.tryParse(json["nutritional_contents"]["energy"]["value"])  : json["nutritional_contents"]["energy"]["value"].toDouble() ,
        unit: "cal"));
    nutritions.add(Nutrition(
        nutritionName: "serving_size_g",
        amount: 100,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fat_total_g",
        amount: json["nutritional_contents"]["fat"] is String ? double.tryParse(json["nutritional_contents"]["fat"] ): (json["nutritional_contents"]["fat"]??0).toDouble() ,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fat_saturated_g",
        amount: double.parse((rng.nextDouble() + rng.nextInt(5)).toStringAsFixed(2)),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "protein_g",
        amount: json["nutritional_contents"]["protein"]  is String ? double.tryParse(json["nutritional_contents"]["protein"] ) : (json["nutritional_contents"]["protein"]??0).toDouble() ,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "sodium_mg",
        amount: json["nutritional_contents"]["sodium"]  is String ? double.tryParse(json["nutritional_contents"]["sodium"] ) : (json["nutritional_contents"]["sodium"]??0).toDouble(),
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "potassium_mg",
        amount:json["nutritional_contents"]["potassium"]  is String ? double.tryParse(json["nutritional_contents"]["potassium"] ) : (json["nutritional_contents"]["potassium"]??0).toDouble(),
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "cholesterol_mg",
        amount: json["nutritional_contents"]["cholesterol"]  is String ? double.tryParse(json["nutritional_contents"]["cholesterol"] ) : (json["nutritional_contents"]["cholesterol"]??0).toDouble(),
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "carbohydrates_total_g",
        amount: json["nutritional_contents"]["carbohydrates"]  is String ? double.tryParse(json["nutritional_contents"]["carbohydrates"] ) : (json["nutritional_contents"]["carbohydrates"]??0).toDouble(),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fiber_g",
        amount: json["nutritional_contents"]["fiber"]  is String ? double.tryParse(json["nutritional_contents"]["fiber"] ) : (json["nutritional_contents"]["fiber"]??0).toDouble(),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "sugar_g",
        amount:json["nutritional_contents"]["sugar"]  is String ? double.tryParse(json["nutritional_contents"]["sugar"] ) : (json["nutritional_contents"]["sugar"]??0).toDouble(),
        unit: "g"));
    String fuuid = const Uuid().v4();

    FoodDTO food = FoodDTO(fuuid, json['description'], "100 gam = 1 number of serving", 1, 100, nutritions);

    RecipeDTO item = RecipeDTO(
      "fromAPI_$uuid",
      json["description"] ?? "",
      1,
      [food],
    );

    return item;
  }
  String getStringDescription() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.first.amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return "${(tt / numberOfServing!).toStringAsFixed(2)} cal per 1 serving";
  }

  String getCaloriesDesStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(0).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return "${(tt / numberOfServing!).toStringAsFixed(0)} cal";
  }

  double getCalories() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(0).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!);
  }

  String getCaloriesStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(0).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getFatTotalStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(1).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getFatSatStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(2).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getCholesterolStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(3).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getProStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(4).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getSodiStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(5).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getPotaStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(6).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getCarbStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(7).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getFiberStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(8).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  String getSugarStr() {
    double tt = 0;
    for (FoodDTO f in foods!) {
      tt += f.nutrition!.elementAt(9).amount *
          (f.servingSize ?? 1) *
          (f.numberOfServing ?? 100) /
          100;
    }
    return (tt / numberOfServing!).toStringAsFixed(2);
  }

  Map<String, dynamic> toJson() => {
        "recipeId": recipeId,
        "title": title,
        "numberOfServing": numberOfServing,
        "foods": foods == null
            ? []
            : List<dynamic>.from(foods!.map((x) => x.toJson())),
      };
}
