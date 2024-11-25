import '../../domain/entities/round_info.dart';
import 'meal_model.dart';

class RoundInfoModel extends RoundInfo{
  RoundInfoModel({
    required super.calories, 
    required super.taxes, 
    required super.month, 
    required super.meals
  });

  // Método fromJson para deserializar un JSON en un objeto RoundInfo
  factory RoundInfoModel.fromJson(Map<String, dynamic> json) {
    return RoundInfoModel(
      calories: json['calories'] as int,
      taxes: json['taxes'] as int,
      month: json['month'] as String,
      meals: (json['meals'] as List<dynamic>)
          .map((mealJson) => MealModel.fromJson(mealJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // Método toJson para serializar un objeto RoundInfo en un JSON
  Map<String, dynamic> toJson() {
    return {
      "calories": calories,
      "taxes": taxes,
      "month": month,
      "meals": meals.map((meal) => meal.toJson()).toList(),
    };
  }
}