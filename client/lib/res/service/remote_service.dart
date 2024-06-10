import 'dart:convert';

import 'package:do_an_2/model/mealDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';

import '../../model/foodDTO.dart';
import 'package:http/http.dart' as http;

class RemoteService{
  Future<List<FoodDTO>> getFoodsFromApi(String searchingQuery) async {
    var client = http.Client();
    var url = Uri.parse(
        "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=$searchingQuery");
    var response = await client.get(url, headers: {
      'X-RapidAPI-Key': "3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf",
      // 'X-RapidAPI-Key': "6f0370dce0msh71dc0a50b4101f6p1aa036jsnc2ac05370b28",
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
  Future<List<RecipeDTO>> getRecipesPredictFromApiMyFitness(String searchingQuery) async {
    var client = http.Client();
    var url = Uri.parse(
        "https://myfitnesspal2.p.rapidapi.com/searchByKeyword?keyword=$searchingQuery");
    var response = await client.get(url, headers: {
      // 'X-RapidAPI-Key': "3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf",
      'X-RapidAPI-Key': "3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf",
      'X-RapidAPI-Host': "myfitnesspal2.p.rapidapi.com"
    });
    List<RecipeDTO> recipes = [];
    if (response.statusCode == 200) {
      dynamic i = json.decode(utf8.decode(response.bodyBytes));
      recipes = List<RecipeDTO>.from(i.map((model) => RecipeDTO.fromApiJson(model)))
          .toList();

    }
    return recipes;
  }
  Future<List<MealDTO>> getDiscoverRecipeFromApi(String searchingQuery) async {
    var client = http.Client();

    var url = Uri.parse("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query=$searchingQuery&sort=calories&sortDirection=asc&minCarbs=0&maxCarbs=1000&minProtein=0&maxProtein=1000&minCalories=0&maxCalories=1000&minFat=0&maxFat=1000&number=10");
    var response = await client.get(url,
        headers: {
          'content-type': 'application/json',
          'X-RapidAPI-Key': '3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf',
          'X-RapidAPI-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
        });
    List<MealDTO> meals = [];
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> i = json.decode(utf8.decode(response.bodyBytes));
      print(i);
      meals = List<MealDTO>.from(i['results'].map((model) => MealDTO.fromApiJson(model)))
          .toList();
    }
    return meals;
  }
}