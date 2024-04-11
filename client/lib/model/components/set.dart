class Set {
  final int rep;
  final double weight;
  final int count;

  const Set({
    required this.rep,
    required this.weight,
    required this.count,
  });


  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      rep: json["rep"] ?? 0,
      weight: json["weight"] ?? 0,
      count: json["count"] ?? 0,
    );
  }
}