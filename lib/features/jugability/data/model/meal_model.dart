import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../../domain/entities/meal.dart';

// Clase modelo MealModel que extiende de Meal
class MealModel extends Meal {
  MealModel({
    required super.name,
    required super.image,
    required super.price,
  });

  // Crear un objeto MealModel a partir de JSON
  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      name: json['name'] as String,
      image: json['image'] as String,
      price: json['price'] as int,
    );
  }

  // Convertir un objeto MealModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
    };
  }
}

// Clase entidad Month
class Month {
  final String name;
  final List<Meal> meals;

  const Month({
    required this.name,
    required this.meals,
  });
}

// Clase modelo MonthModel que extiende de Month
class MonthModel extends Month {
  const MonthModel({
    required super.name,
    required List<MealModel> super.meals,
  });

  // Crear un objeto MonthModel a partir de JSON
  factory MonthModel.fromJson(Map<String, dynamic> json) {
    var mealsList = json['meals'] as List;
    List<MealModel> meals = mealsList.map((meal) => MealModel.fromJson(meal)).toList();

    return MonthModel(
      name: json['month'] as String,
      meals: meals,
    );
  }

  // Convertir un objeto MonthModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'month': name,
      'meals': meals.map((meal) => (meal as MealModel).toJson()).toList(),
    };
  }
}

class DataParser {
  static List<MonthModel> _months = [];

  // Cargar datos desde assets y almacenar en la lista _months
  static Future<void> loadMonthsFromAssets(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    var monthsList = jsonData['months'] as List;
    _months = monthsList.map((month) => MonthModel.fromJson(month)).toList();
  }

  // Método para obtener las comidas de un mes en particular
  static List<MealModel>? getMealsByMonthName(String monthName) {
    final month = _months.firstWhere(
      (month) => month.name.toLowerCase() == monthName.toLowerCase(),
    );
    return month.meals.cast<MealModel>();
  }
}
