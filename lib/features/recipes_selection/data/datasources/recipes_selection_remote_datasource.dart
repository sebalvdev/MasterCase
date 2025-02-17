import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/cache_constants.dart';
import '../models/recipe_item_model.dart';

abstract class RecipesSelectionRemoteDatasource {
  Future<List<RecipeItemModel>> getRecipeItems();
}

class RecipesSelectionRemoteDatasourceImpl implements RecipesSelectionRemoteDatasource {
  final FirebaseFirestore firestore;
  final SharedPreferences prefs;

  RecipesSelectionRemoteDatasourceImpl({
    required this.firestore, 
    required this.prefs
  });
  
  @override
  Future<List<RecipeItemModel>> getRecipeItems() async {

    final cacheRecipes = prefs.getString(cacheRecipesList);

    if(cacheRecipes == null) {
      // print('no se tiene recetas almacenadas en cache');

      final recipes = await firestore
      .collection('games')
      .doc('emXYuSuveWscid36xb65')
      .collection('meals')
      .get();

      final List<RecipeItemModel> recipeItems = [];

      for (final recipe in recipes.docs) {
        // print('receta que esta ingresando: ${recipe.data()}');
        RecipeItemModel recipeItem = RecipeItemModel.fromJson(recipe.data());
        recipeItems.add(recipeItem);
      }

      final cacheRecipes = recipeItemModelListToString(recipeItems);
      prefs.setString(cacheRecipesList, cacheRecipes);

      return recipeItems;
    } else {
      // print('se tiene recetas almacenadas en cache');
      final recipeList = recipeItemModelListFromJson(cacheRecipes);
      return recipeList;
    }
  }
}