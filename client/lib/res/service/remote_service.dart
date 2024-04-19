import 'dart:convert';

import '../../model/foodDTO.dart';
import 'package:http/http.dart' as http;

class RemoteService{
  Future<List<FoodDTO>> getFoodsFromApi(String searchingQuery) async {
    var client = http.Client();
    //var query = searchingQuery;
    //var query2 = {"query": query};
    // 'content-type': 'application/x-www-form-urlencoded',
    var url = Uri.parse(
        "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=$searchingQuery");
    var response = await client.get(url, headers: {
      // 'X-RapidAPI-Key': "3fb34c9a9emshdf9e39788ac293dp19ac8ejsna599162717bf",
      'X-RapidAPI-Key': "6f0370dce0msh71dc0a50b4101f6p1aa036jsnc2ac05370b28",
      'X-RapidAPI-Host': "nutrition-by-api-ninjas.p.rapidapi.com"
    });
    List<FoodDTO> foods = [];
    if (response.statusCode == 200) {
      print(response.body);
      dynamic i = json.decode(utf8.decode(response.bodyBytes));
      print(i);
       foods = List<FoodDTO>.from(i.map((model) => FoodDTO.fromApiJson(model)))
          .toList();

    }
    return foods;
  }
}