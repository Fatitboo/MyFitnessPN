
class Nutrition {
   String nutritionName;
   double amount;
   String unit;

   Nutrition({
    required this.nutritionName,
    required this.amount,
    required this.unit,
  });


  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      nutritionName: json["nutritionName"] ?? "",
      amount: json["amount"] ?? 0,
      unit: json["unit"] ?? "",
    );
  }
   Map<String, dynamic> toJson() => {
     "nutritionName": nutritionName,
     "amount": amount.toStringAsFixed(2),
     "unit": unit,
   };
}