import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/recipe_item.dart';

List<RecipeItemModel> recipeItemModelListFromJson(String str) =>
    List<RecipeItemModel>.from(
      json.decode(str).map((x) => RecipeItemModel.fromJson(x)));

String recipeItemModelListToString(List<RecipeItemModel> recipes) =>
    json.encode(List<dynamic>.from(recipes.map((x) => x.toJson())));

class RecipeItemModel extends RecipeItem {
  const RecipeItemModel({
    required super.mealName, 
    required super.mealImage, 
    required super.frecuencies
  });

  factory RecipeItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    return RecipeItemModel(
      mealName: snapshot['mealName'],
      mealImage: snapshot['mealImage'],
      frecuencies: snapshot['frecuencies'],
    );
  }

  factory RecipeItemModel.fromJson(Map<String, dynamic> json) {
    return RecipeItemModel(
      mealName: json['mealName'],
      mealImage: json['mealImage'],
      frecuencies: json['frecuencies'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mealName": mealName,
      "mealImage": mealImage,
      "frecuencies": frecuencies,
    };
  }
}