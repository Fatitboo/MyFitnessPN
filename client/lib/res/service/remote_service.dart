import 'dart:convert';

import 'package:do_an_2/model/mealDTO.dart';

import '../../model/foodDTO.dart';
import 'package:http/http.dart' as http;

class RemoteService{
  Future<List<FoodDTO>> getFoodsFromApi(String searchingQuery) async {
    var client = http.Client();
    var url = Uri.parse(
        "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=$searchingQuery");
    var response = await client.get(url, headers: {
      // 'X-RapidAPI-Key': "3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf",
      'X-RapidAPI-Key': "6f0370dce0msh71dc0a50b4101f6p1aa036jsnc2ac05370b28",
      'X-RapidAPI-Host': "nutrition-by-api-ninjas.p.rapidapi.com"
    });
    List<FoodDTO> foods = [];
    if (response.statusCode == 200) {
      dynamic i = json.decode(utf8.decode(response.bodyBytes));
       foods = List<FoodDTO>.from(i.map((model) => FoodDTO.fromApiJson(model)))
          .toList();

    }
    return foods;
  }
  Future<List<MealDTO>> getDiscoverRecipeFromApi(String searchingQuery) async {
    var client = http.Client();
    var item = {
      "query":searchingQuery
    };
    Object obj = jsonEncode(item);
    var url = Uri.parse("https://recipe-food-nutrition14.p.rapidapi.com/recipee-search");
    var response = await client.post(url,
        headers: {
          'content-type': 'application/json',
          'X-RapidAPI-Key': '3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf',
          'X-RapidAPI-Host': 'recipe-food-nutrition14.p.rapidapi.com'
        },
        body:obj
    );
    List<MealDTO> meals = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> i = json.decode(utf8.decode(response.bodyBytes));
      meals = List<MealDTO>.from(i['hits'].map((model) => MealDTO.fromApiJson(model['recipe'])))
          .toList();
    }
    return meals;
  }
}