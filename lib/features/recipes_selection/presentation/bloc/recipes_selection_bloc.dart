import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/recipe_item.dart';
import '../../domain/usecases/get_recipe_items.dart' as get_recipe_items;

part 'recipes_selection_event.dart';
part 'recipes_selection_state.dart';

class RecipesSelectionBloc extends Bloc<RecipesSelectionEvent, RecipesSelectionState> {

  final get_recipe_items.GetRecipeItems getRecipeItems;

  RecipesSelectionBloc({
    required this.getRecipeItems
  }) : super(RecipesSelectionInitial()) {

    on<GetRecipesEvent>((event, emit) async {
      emit(RecipesSelectionLoading());
      final result = await getRecipeItems.call(NoParams());
      result.fold(
        (failure) => emit(RecipesSelectionError()), 
        (recipeItems) => emit(RecipesSelectionLoaded(recipeItems: recipeItems))
      );
    });

  }
}
