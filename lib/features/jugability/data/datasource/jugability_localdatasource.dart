// ignore_for_file: avoid_print

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/round_info.dart';
import '../model/meal_model.dart';

abstract class JugabilityLocalDataSource {
  Future<RoundInfo> getInfoRound();
  Future<RoundInfo?> nextInfoRound(String month);
}

class JugabilityLocalDataSourceImpl implements JugabilityLocalDataSource {
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  @override
  Future<RoundInfo> getInfoRound() async {
    final int calories = Random().nextInt(6) + 1;
    final int taxes = Random().nextInt(6) + 1;
    final String month = sharedPreferences.getString(cacheLastMonth)!;
    final List<MealModel> meals = await getMeals(month);

    return RoundInfo(
        calories: calories, taxes: taxes, month: month, meals: meals);
  }

  Future<List<MealModel>> getMeals(String month) async {
    // const String month = 'Enero';

    await DataParser.loadMonthsFromAssets('assets/data/meals.json');
    List<MealModel>? meals = DataParser.getMealsByMonthName(month);

    if (meals != null && meals.isNotEmpty) {
      List<MealModel> weightedMeals = [];
      for (var meal in meals) {
        weightedMeals.addAll(List.generate(meal.value, (_) => meal));
      }

      Random random = Random();
      List<MealModel> selectedMeals = List.generate(3, (_) {
        return weightedMeals[random.nextInt(weightedMeals.length)];
      });

      return selectedMeals;
    } else {
      print("Mes no encontrado o sin comidas disponibles");
      return [];
    }
  }

  @override
  Future<RoundInfo?> nextInfoRound(String month) async {
    try {
      final months = [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre'
      ];


      // Recuperar el mes actual desde el caché
      final String? currentMonth =
          sharedPreferences.getString('cacheLastMonth');

      if (currentMonth != null) {
        // Encontrar el índice del mes actual
        int currentIndex = months.indexOf(currentMonth);

        if(currentIndex >= months.length){
          return null;
        }
        int nextIndex = (currentIndex + 1);
        String nextMonth = months[nextIndex];

        // Guardar el siguiente mes en el caché
        await sharedPreferences.setString('cacheLastMonth', nextMonth);
      } else {
        print("No se encontró el mes en el caché.");
      }
    } catch (e) {
      print('Error en nextmonth: $e');
    }
    return getInfoRound();
  }
}
