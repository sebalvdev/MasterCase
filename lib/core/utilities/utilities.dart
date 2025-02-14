// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:master_case/features/jugability/data/model/meal_model.dart';
import 'package:master_case/features/jugability/data/model/round_info_model.dart';
import 'package:master_case/features/jugability/domain/entities/meal.dart';
import 'package:master_case/features/jugability/domain/entities/round_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';
import '../constants/constants.dart';

class Utilities {
  FirebaseFirestore firebaseFirestore = sl<FirebaseFirestore>();
  SharedPreferences sharedPreferences = sl<SharedPreferences>();

  String getPlayersRestaurantNames() {
    return sharedPreferences.getStringList(cacheRestaurantNames)!.join(", ");
  }

  void setRestaurantNames(List<String> restaurantNames) {
    sharedPreferences.setStringList(cacheRestaurantNames, restaurantNames);
  }

  void setNumberOfPlayers(int numberPlayers) {
    sharedPreferences.setInt(cacheNumberOfPlayers, numberPlayers);
  }

  int getNumberOfPlayers() {
    return sharedPreferences.getInt(cacheNumberOfPlayers) ?? 0;
  }

  String setLastMonth(String month) {
    sharedPreferences.setString(cacheLastMonth, month);
    return month;
  }

  String getLastMonth() {
    return sharedPreferences.getString(cacheLastMonth) ?? "Enero";
  }

  List<MealModel> mergeMeals(List<bool> lastCardsState, List<MealModel> meals, List<MealModel> newMeals) {
  // Asegúrate de que las listas tengan el mismo tamaño
  if (lastCardsState.length != meals.length ||
      meals.length != newMeals.length) {
    throw ArgumentError("Las listas deben tener el mismo tamaño.");
  }

  // Construye la nueva listas según la lógica
  List<MealModel> mergeOfMeals = [];
  for (int i = 0; i < lastCardsState.length; i++) {
    // Si el estado es `true`, toma de `meals`, de lo contrario de `newMeals`
    mergeOfMeals.add(lastCardsState[i] ? meals[i] : newMeals[i]);
  }

  return mergeOfMeals;
}

  RoundInfoModel getCurrentRoundInfoFromCache() {
    final roundInfoString = sharedPreferences.getString(cacheCurrentRoundInfo);
    RoundInfoModel roundInfoModel = RoundInfoModel.fromJson(jsonDecode(roundInfoString!));
    return roundInfoModel;
  }

  Future<bool> saveCurrentRoundInfoInCache(RoundInfo currentRoundInfo) {
    RoundInfoModel roundInfoModel = RoundInfoModel(
      calories: currentRoundInfo.calories,
      taxes: currentRoundInfo.taxes,
      month: currentRoundInfo.month,
      meals: currentRoundInfo.meals,
    );

    String roundInfoString = jsonEncode(roundInfoModel.toJson());

    return sharedPreferences.setString(cacheCurrentRoundInfo, roundInfoString);
  }
  //dudoso
  Future<void> saveCardState(List<bool> boolList) async {
    // Convertimos la lista de bool a una lista de enteros (1 para true, 0 para false)
    List<int> intList = boolList.map((bool value) => value ? 1 : 0).toList();
    // Guardamos la lista de enteros como una cadena JSON
    await sharedPreferences.setString(cacheCurrentCardState, intList.toString());
  }

  //dudoso
  List<bool> getCurrentCardsState() {
    // Recuperamos la cadena JSON
    String? intListString = sharedPreferences.getString(cacheCurrentCardState);
    if (intListString == null) {
      return []; // Retornamos lista vacía si no hay datos
    }

    // Convertimos la cadena en una lista de enteros
    List<int> intList = intListString
        .replaceAll('[', '') // Quitamos los corchetes
        .replaceAll(']', '') // Quitamos los corchetes
        .split(',')
        .map((e) => int.tryParse(e.trim()) ?? 0) // Convertimos a enteros
        .toList();

    // Convertimos la lista de enteros a una lista de booleanos
    return intList.map((int value) => value == 1).toList();
  }

  Future<void> setTimerState(bool state) {
    return sharedPreferences.setBool(cacheTimerExpired, state);
  }

  //dudoso
  List<Meal> getLastUnflippedMeals() {
    List<String> mealsSaved =
        sharedPreferences.getStringList(cacheCurrentRoundMeal) ?? [];
    List<Meal> meals = [];

    for (String meal in mealsSaved) {
      MealModel mealModel = MealModel.fromJson(jsonDecode(meal));
      meals.add(Meal(
          name: mealModel.name,
          image: mealModel.image,
          value: mealModel.value));
    }
    return meals;
  }

  //dudoso
  Future<void> saveCurrentRoundInfo(Meal currentMeal) async {
    List<String> mealsSaved =
        sharedPreferences.getStringList(cacheCurrentRoundMeal) ?? [];
    MealModel mealModel = MealModel(
      name: currentMeal.name,
      image: currentMeal.image,
      value: currentMeal.value,
    );
    String mealString = jsonEncode(mealModel.toJson());

    mealsSaved.add(mealString);
    await sharedPreferences.setStringList(cacheCurrentRoundMeal, mealsSaved);
  }

  Future<void> resetCurrentRoundInfo() async {
    await sharedPreferences.remove(cacheCurrentRoundMeal);
  }

  Future<void> setCacheData(String metaData) async {
    await sharedPreferences.setString(cacheUserRegistered, metaData);
    await sharedPreferences.setBool(cacheFlagRegistered, true);
  }

  String getDeviceData() {
    return sharedPreferences.getString(cacheUserRegistered) ?? "Error";
  }

  bool getFlagRegistered() {
    return sharedPreferences.getBool(cacheFlagRegistered) ?? false;
  }

  Future<bool> registeredDevice() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;

      final snapshot = await firebaseFirestore
          .collection(gamesTable)
          .doc(masterCase)
          .collection(boxesColection)
          .doc(boxIdTest)
          .collection(users)
          .get();

      for (var doc in snapshot.docs) {
        final docData = doc.data();
        print(
            'informacion del dispositivo: ${docData['device']} - ${deviceInfo.fingerprint}');
        if (docData['device'] == deviceInfo.fingerprint) {
          return true;
        }
      }
    } on Exception catch (e) {
      print(e);
    }

    return false; // Retorna falso si no encuentra el dispositivo
  }

  void setUserLogged() {
    sharedPreferences.setBool(cacheUserLogged, true);
  }

  bool isUserLogged() {
    return sharedPreferences.getBool(cacheUserLogged) ?? false;
  }
}
