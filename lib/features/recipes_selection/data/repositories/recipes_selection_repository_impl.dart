import 'package:dartz/dartz.dart';
import 'package:master_case/core/network/network_info.dart';
import 'package:master_case/features/recipes_selection/data/datasources/recipes_selection_remote_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/recipe_item.dart';
import '../../domain/repositories/recipes_selection_repository.dart';

class RecipesSelectionRepositoryImpl implements RecipesSelectionRepository {

  final RecipesSelectionRemoteDatasource recipeSelectionRemoteDatasource;
  final NetworkInfo networkInfo;

  RecipesSelectionRepositoryImpl({
    required this.recipeSelectionRemoteDatasource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, List<RecipeItem>>> getRecipeItems() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRecipeItems = await recipeSelectionRemoteDatasource.getRecipeItems();
        return Right(remoteRecipeItems);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

}