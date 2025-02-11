part of 'recipes_selection_bloc.dart';

sealed class RecipesSelectionState extends Equatable {
  const RecipesSelectionState();
  
  @override
  List<Object> get props => [];
}

final class RecipesSelectionInitial extends RecipesSelectionState {}

final class RecipesSelectionLoading extends RecipesSelectionState {}

final class RecipesSelectionLoaded extends RecipesSelectionState {
  final List<RecipeItem> recipeItems;

  const RecipesSelectionLoaded({required this.recipeItems});

  @override
  List<Object> get props => [recipeItems];
}

final class RecipesSelectionError extends RecipesSelectionState {}
