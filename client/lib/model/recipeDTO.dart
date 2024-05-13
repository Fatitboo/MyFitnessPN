import 'package:do_an_2/model/foodDTO.dart';

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
