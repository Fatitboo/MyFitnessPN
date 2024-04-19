import 'package:do_an_2/model/foodDTO.dart';
class RecipeDTO {
  String? recipeId;
  String? title;
  double? numberOfServing;
  List<FoodDTO>? foods;


  RecipeDTO(this.recipeId, this.title,  this.numberOfServing, this.foods);

  factory RecipeDTO.fromJson(Map<String, dynamic> json) {
    RecipeDTO item = RecipeDTO(
        json["recipeId"] ?? "",
        json["title"] ?? "",
        json["numberOfServing"] ?? 0 as double,
        json["foods"] != null ? (json["foods"] as List).map((e) => FoodDTO.fromJson(e)).toList() : [],
      );

      return item;
  }

  String getStringDescription(){
    double tt = 0;
    for(FoodDTO f in foods!){
      tt+= f.nutrition!.first.amount*(f.servingSize??1)*(f.numberOfServing??100)/100;
    }
    return "${tt*(numberOfServing??1)} cal, $numberOfServing portions";

  }
  Map<String, dynamic> toJson() => {
    "recipeId": recipeId,
    "title": title,
    "numberOfServing": numberOfServing,
    "foods": foods == null? []: List<dynamic>.from(foods!.map((x) => x.toJson())),
  };
}