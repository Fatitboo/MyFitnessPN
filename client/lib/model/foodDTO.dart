import 'package:do_an_2/model/components/nutrition.dart';
import 'package:uuid/uuid.dart';

class FoodDTO {
  String? foodId;
  String? foodName;
  String? description;
  double? numberOfServing;
  double? servingSize;
  List<Nutrition>? nutrition;

  FoodDTO(this.foodId, this.foodName, this.description, this.numberOfServing,
      this.servingSize, this.nutrition);

  factory FoodDTO.fromJson(Map<String, dynamic> json) {
    FoodDTO item = FoodDTO(
      json["foodId"] ?? "",
      json["foodName"] ?? "",
      json["description"] ?? "",
      json["numberOfServing"] ?? 0.0,
      json["servingSize"] ?? 0.0,
      json["nutrition"] != null
          ? (json["nutrition"] as List).map((e) => Nutrition.fromJson(e)).toList()
          : [],
    );

    return item;
  }
  factory FoodDTO.fromApiJson(Map<String, dynamic> json) {
    List<Nutrition> nutritions = [];
    nutritions.add(Nutrition(
        nutritionName: "calories",
        amount: json["calories"] is String ? double.tryParse(json["calories"]) ?? 0.0 : json["calories"]?.toDouble(),
        unit: "cal"));
    nutritions.add(Nutrition(
        nutritionName: "serving_size_g",
        amount: json["serving_size_g"] is String ? double.tryParse(json["serving_size_g"]) ?? 0.0 : json["serving_size_g"]?.toDouble(),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fat_total_g",
        amount: json["fat_total_g"] is String ? double.tryParse(json["fat_total_g"]) ?? 0.0 : json["fat_total_g"]?.toDouble(),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fat_saturated_g",
        amount: json["fat_saturated_g"] is String ? double.tryParse(json["fat_saturated_g"]) ?? 0.0 : json["fat_saturated_g"]?.toDouble(),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "protein_g",
        amount: json["protein_g"] is String ? double.tryParse(json["protein_g"]) ?? 0.0 : json["protein_g"] + .0,
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "sodium_mg",
        amount: json["sodium_mg"] is String ? double.tryParse(json["sodium_mg"]) ?? 0.0 : json["sodium_mg"] + .0,
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "potassium_mg",
        amount: json["potassium_mg"] is String ? double.tryParse(json["potassium_mg"]) ?? 0.0 : json["potassium_mg"] + .0,
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "cholesterol_mg",
        amount: json["cholesterol_mg"] is String ? double.tryParse(json["cholesterol_mg"]) ?? 0.0 : json["cholesterol_mg"]?.toDouble(),
        unit: "mg"));
    nutritions.add(Nutrition(
        nutritionName: "carbohydrates_total_g",
        amount: json["carbohydrates_total_g"] is String ? double.tryParse(json["carbohydrates_total_g"]) ?? 0.0 : json["carbohydrates_total_g"]?.toDouble(),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "fiber_g",
        amount: json["fiber_g"] is String
            ? double.tryParse(json["fiber_g"]) ?? 0.0
            : json["fiber_g"]?.toDouble(),
        unit: "g"));
    nutritions.add(Nutrition(
        nutritionName: "sugar_g",
        amount: json["sugar_g"] is String ? double.tryParse(json["sugar_g"]) ?? 0.0 : json["sugar_g"]?.toDouble(),
        unit: "g"));
    String uuid = const Uuid().v4();
    FoodDTO item = FoodDTO(uuid, json["name"] ?? "", "${json["serving_size_g"]} gam" ?? "", 1, 100, nutritions);

    return item;
  }
  String getStringDescription() {
    return "${(nutrition!.elementAt(0).amount*servingSize!*numberOfServing!/100).toStringAsFixed(2)} cal for 1 serving = ${servingSize!*numberOfServing!} g ";
  }
  String getCalDes() {
    return "${(nutrition!.elementAt(0).amount*servingSize!*numberOfServing!/100).toStringAsFixed(0)} cal";
  }
  double getCals(){
    return (nutrition!.elementAt(0).amount*servingSize!*numberOfServing!/100);
  }
  void multiplyIndex(double multiply) {
    nutrition?.forEach((element) {
      element.amount *= multiply;
    });
  }

  Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "foodName": foodName,
        "description": description,
        "numberOfServing": numberOfServing,
        "servingSize": servingSize,
        "nutrition": nutrition == null? []: List<dynamic>.from(nutrition!.map((x) => x.toJson())),
      };
}
