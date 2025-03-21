import 'package:do_an_2/model/logExerciseItemDTO.dart';
import 'package:do_an_2/model/logFoodItemDTO.dart';

class LogDiaryDTO {
  String? logDiaryItemId;
  String? logDiaryType;
  double? water;
  LogFoodItemDTO? foodLogItem;
  LogExerciseItemDTO? exerciseLogItem;

  LogDiaryDTO(this.logDiaryItemId, this.logDiaryType, this.water,
      this.foodLogItem, this.exerciseLogItem);

  factory LogDiaryDTO.fromJson(Map<String, dynamic> json) {
    LogDiaryDTO item = LogDiaryDTO(
      json["logDiaryItemId"] ?? "",
      json["logDiaryType"] ?? "",
      json["water"] ?? 0 as double,
      json["foodLogItem"] != null
          ? LogFoodItemDTO.fromJson(json["foodLogItem"])
          : null,
      json["exerciseLogItem"] != null
          ? LogExerciseItemDTO.fromJson(json["exerciseLogItem"])
          : null,
    );

    return item;
  }

  // Map<String, dynamic> toJson() => {
  //   "logDiaryItemId": logDiaryItemId,
  //   "title": title,
  //   "numberOfServing": numberOfServing,
  //   "foods": foods == null? []: List<dynamic>.from(foods!.map((x) => x.toJson())),
  // };
}
