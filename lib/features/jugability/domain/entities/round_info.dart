import '../../data/model/meal_model.dart';

class RoundInfo {
  final int calories;
  final int taxes;
  final String month;
  final List<MealModel> meals;

  RoundInfo(
      {required this.calories,
      required this.taxes,
      required this.month,
      required this.meals});
}
