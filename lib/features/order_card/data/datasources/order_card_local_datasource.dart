import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utilities/utilities.dart';
import '../../../recipes_selection/data/models/recipe_item_model.dart';
import '../models/order_card_info_model.dart';

abstract class OrderCardLocalDatasource {
  Future<OrderCardInfoModel> getOrderCardInfo();
}

class OrderCardLocalDatasourceImpl implements OrderCardLocalDatasource {
  final Utilities utilities = Utilities();
  final SharedPreferences prefs;

  OrderCardLocalDatasourceImpl({required this.prefs});

  @override
  Future<OrderCardInfoModel> getOrderCardInfo() {
    //mes actual
    String actualMonth = utilities.getCurrentMonthText();
    //recetas que fueron seleccionadas por el usuario
    final rawInGameRecipes = utilities.getInGameRecipesGroup();
    List<RecipeItemModel> recipeItems = recipeItemModelListFromJson(rawInGameRecipes);
    //receta aleatoria segun frecuencia del mes actual
    RecipeItemModel randomRecipe = getRandomRecipeByMonth(actualMonth, recipeItems);
    //cantidad aleatoria del pedido
    int randomQuantity = Random().nextInt(5) + 1;

    OrderCardInfoModel orderCardInfo = OrderCardInfoModel(
      recipeName: randomRecipe.mealName,
      recipePrice: 100,
      recipeImage: randomRecipe.mealImage,
      recipeQuantity: randomQuantity,
    );

    print('pedido aleatorio: ${orderCardInfo.recipeName} - ${orderCardInfo.recipeQuantity}');
    return Future.value(orderCardInfo);
  }

  RecipeItemModel getRandomRecipeByMonth(String month, List<RecipeItemModel> inGameRecipeItems) {
    List<RecipeItemModel> mealChoices = [];

    for (var recipe in inGameRecipeItems) {
      if (recipe.frequencies.containsKey(month)) {
        int frequency = recipe.frequencies[month]!;
        for (int i = 0; i < frequency; i++) {
          mealChoices.add(recipe);
        }
      }
    }

    if (mealChoices.isNotEmpty) {
      Random random = Random();
      return mealChoices[random.nextInt(mealChoices.length)];
    } else {
      return inGameRecipeItems[0];
    }
  }
}
