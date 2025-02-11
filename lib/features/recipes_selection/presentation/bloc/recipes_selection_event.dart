part of 'recipes_selection_bloc.dart';

sealed class RecipesSelectionEvent extends Equatable {
  const RecipesSelectionEvent();

  @override
  List<Object> get props => [];
}

class GetRecipesEvent extends RecipesSelectionEvent {}
