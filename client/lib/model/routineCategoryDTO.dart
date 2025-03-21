
class RoutineCategoryDTO {

  String? routCategoryId;
  String? name;
  String? description;

  RoutineCategoryDTO(
    this.routCategoryId,
    this.name,
    this.description,
  );

  RoutineCategoryDTO.init();

  factory RoutineCategoryDTO.fromJson(Map<String, dynamic> json) {
    RoutineCategoryDTO item = RoutineCategoryDTO(
      json["routCategoryId"] ?? "",
      json["name"] ?? "",
      json["description"] ?? "",
    );
    return item;
  }

  Map<String, dynamic> toJson(RoutineCategoryDTO routineCategoryDTO) {
    return {
      "routCategoryId": routineCategoryDTO.routCategoryId,
      "name": routineCategoryDTO.name,
      "description": routineCategoryDTO.description,
    };
  }
}