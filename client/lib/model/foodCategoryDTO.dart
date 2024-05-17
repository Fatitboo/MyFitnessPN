
class MealCategoryDTO {

  String? mealCategoryId;
  String? name;
  String? description;

  MealCategoryDTO(
    this.mealCategoryId,
    this.name,
    this.description,
  );

  MealCategoryDTO.init();

  factory MealCategoryDTO.fromJson(Map<String, dynamic> json) {
    MealCategoryDTO item = MealCategoryDTO(
      json["mealCategoryId"] ?? "",
      json["name"] ?? "",
      json["description"] ?? "",
    );
    return item;
  }

  Map<String, dynamic> toJson(MealCategoryDTO mealCategoryDTO) {
    return {
      "routCategoryId": mealCategoryDTO.mealCategoryId,
      "name": mealCategoryDTO.name,
      "description": mealCategoryDTO.description,
    };
  }
}