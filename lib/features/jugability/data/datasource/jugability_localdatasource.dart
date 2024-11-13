// ignore_for_file: avoid_print

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/round_info.dart';
import '../model/meal_model.dart';

abstract class JugabilityLocalDataSource {
  Future<RoundInfo> getInfoRound();
}

class JugabilityLocalDataSourceImpl implements JugabilityLocalDataSource {
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  @override
  Future<RoundInfo> getInfoRound() async {
    await sharedPreferences.setString(cacheLastMonth, 'Enero');
    final int calories = Random().nextInt(6) + 1;
    final int taxes = Random().nextInt(6) + 1;
    final String month = sharedPreferences.getString(cacheLastMonth)!;
    final List<MealModel> meals = await getMeals();

    return RoundInfo(
        calories: calories, 
        taxes: taxes, 
        month: month, 
        meals: meals
      );
  }

  Future<List<MealModel>> getMeals() async {
    const String month = 'Enero';

    // Cargar los datos desde el archivo JSON
    await DataParser.loadMonthsFromAssets('assets/data/meals.json');

    // Obtener las comidas del mes especificado
    List<MealModel>? meals = DataParser.getMealsByMonthName(month);

    if (meals != null && meals.isNotEmpty) {
      // Barajar la lista de comidas y tomar 3 elementos al azar
      meals.shuffle(Random());
      return meals.take(3).toList();
    } else {
      print("Mes no encontrado o sin comidas disponibles");
      return [];
    }
  }
}
