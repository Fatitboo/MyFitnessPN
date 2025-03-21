
class PlanTypeDTO {

  String? planTypeId;
  String? name;
  String? description;

  PlanTypeDTO(
    this.planTypeId,
    this.name,
    this.description,
  );

  PlanTypeDTO.init();

  factory PlanTypeDTO.fromJson(Map<String, dynamic> json) {
    PlanTypeDTO item = PlanTypeDTO(
      json["planTypeId"] ?? "",
      json["name"] ?? "",
      json["description"] ?? "",
    );
    return item;
  }

  Map<String, dynamic> toJson(PlanTypeDTO planTypeDTO) {
    return {
      "planTypeId": planTypeDTO.planTypeId,
      "name": planTypeDTO.name,
      "description": planTypeDTO.description,
    };
  }
}