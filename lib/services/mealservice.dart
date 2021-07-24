import 'package:flutter_app_ui/models/CurtItems.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_ui/models/meal.dart';

class ProductAPI {

  String BASE_URL = 'http://sulewobgu.pythonanywhere.com';

  Future<List<Meal>> findAll() async {
    var response = await http.get(
        "http://mashfoodapp.pythonanywhere.com/firstfivefood");
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((meal) => Meal.fromJson(meal)).toList();
    }
    else {
      throw Exception('failed to load');
    }
  }

  Future<Meal> find(int mealId) async {
    var response = await http.get(
        "http://mashfoodapp.pythonanywhere.com/meal_detail/${mealId}");
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body
          .map((meal) => Meal.fromJson(meal))
          .toList()
          .first;
    }
    else {
      throw Exception('failed to load');
    }
  }

  Future<List<CurtItems>> findAllInCurt(int userId) async {
    var response = await http.get(
        "http://mashfoodapp.pythonanywhere.com/insidemycurt//${userId}");
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((curtitems) => CurtItems.fromJson(curtitems)).toList();
    }
    else {
      throw Exception('failed to load');
    }
  }



}