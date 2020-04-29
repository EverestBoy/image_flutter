import 'package:flutter/foundation.dart';


class FoodModel  {
  
  String name;
  double carbs;
  double fats;
  double proteins;
  double calories;

  void set setname(String  name) {
    this.name = name;
  }

  void set setcarbs(double carbs) {
    this.carbs = carbs;
  }

  void set setfats(double fats) {
    this.fats = fats;
  }

  void set setproteins(double proteins) {
    this.proteins = proteins;
  }

  void set setcalories(double calories) {
    this.calories = calories;
  }

  FoodModel({
    @required this.name,
    @required this.carbs,
    @required this.fats,
    @required this.proteins,
    @required this.calories,
  });

   factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      name: json['name'] as String,
      carbs: json['carbs'] as double,
      fats: json['fats'] as double,
      proteins: json['proteins'] as double,
      calories: json['calories'] as double,
    );
  }

  
}
