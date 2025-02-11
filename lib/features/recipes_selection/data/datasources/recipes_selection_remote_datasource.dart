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

    if(cacheRecipes != null) {
      print('no se tiene recetas almacenadas en cache');
    } else {
      print('se tiene recetas almacenadas en cache');
    }

    return [];
  }
}