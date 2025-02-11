import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/recipe_item.dart';
import '../repositories/recipes_selection_repository.dart';

class GetRecipeItems implements UseCase<List<RecipeItem>, NoParams> {
  final RecipesSelectionRepository repository;

  GetRecipeItems({required this.repository});

  @override
  Future<Either<Failure, List<RecipeItem>>> call(NoParams params) async {
    return await repository.getRecipeItems();
  }
}