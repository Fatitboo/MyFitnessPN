class DetectResponseDTO {
  List<int> classIds;
  List<int> imageSize;
  List<String> masks;
  String msg;
  List<Roi> rois;
  List<double> scores;

  DetectResponseDTO({
    required this.classIds,
    required this.imageSize,
    required this.masks,
    required this.msg,
    required this.rois,
    required this.scores,
  });

  factory DetectResponseDTO.fromJson(Map<String, dynamic> json) {
    var roisFromJson = json['rois'] as List;
    List<Roi> roisList = roisFromJson.map((i) => Roi.fromJson(i)).toList();

    return DetectResponseDTO(
      classIds: List<int>.from(json['class_ids']),
      imageSize: List<int>.from(json['image_size']),
      masks: List<String>.from(json['masks']),
      msg: json['msg'],
      rois: roisList,
      scores: List<double>.from(json['scores']),
    );
  }
}

class Roi {
  int x;
  int y;
  int height;
  int width;

  Roi({
    required this.x,
    required this.y,
    required this.height,
    required this.width,
  });

  factory Roi.fromJson(List<dynamic> json) {
    return Roi(
      x: json[0],
      y: json[1],
      height: json[2],
      width: json[3],
    );
  }
}
