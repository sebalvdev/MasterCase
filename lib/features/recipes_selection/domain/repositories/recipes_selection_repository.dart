import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/recipe_item.dart';

abstract class RecipesSelectionRepository {
  Future<Either<Failure, List<RecipeItem>>> getRecipeItems ();
}