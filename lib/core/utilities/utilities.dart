// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:master_case/features/jugability/data/model/meal_model.dart';
import 'package:master_case/features/jugability/domain/entities/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';
import '../constants/constants.dart';

class Utilities {
  FirebaseFirestore firebaseFirestore = sl<FirebaseFirestore>();
  SharedPreferences sharedPreferences = sl<SharedPreferences>();

  Future<void> saveCardState(List<bool> boolList) async {
    // Convertimos la lista de bool a una lista de enteros (1 para true, 0 para false)
    List<int> intList = boolList.map((bool value) => value ? 1 : 0).toList();
    // Guardamos la lista de enteros como una cadena JSON
    await sharedPreferences.setString(cacheCurrentCardState, intList.toString());
  }

  List<bool> getCurrentCardsState() {
    // Recuperamos la cadena JSON
    String? intListString = sharedPreferences.getString(cacheCurrentCardState);
    if (intListString == null)
      return []; // Retornamos lista vacía si no hay datos

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
