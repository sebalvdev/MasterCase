import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/features/recipes_selection/domain/entities/recipe_item.dart';
import 'package:master_case/features/recipes_selection/presentation/bloc/recipes_selection_bloc.dart';
import 'package:master_case/injection_container.dart';

class RecipesSelectionPage extends StatelessWidget {
  const RecipesSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<RecipesSelectionBloc> buildBody(BuildContext context) {
    List<RecipeItem> recipeItems = [];

    return BlocProvider(
      create: (context) => sl<RecipesSelectionBloc>(),
      child: Center(
        child: BlocBuilder<RecipesSelectionBloc, RecipesSelectionState>(
          builder: (context, state) {
            if (state is RecipesSelectionInitial) {
              BlocProvider.of<RecipesSelectionBloc>(context).add(GetRecipesEvent());
              print('estado inicial pagina de recetas');
            }

            if (state is RecipesSelectionLoading) {
              print('estado de carga pagina de recetas');
            }

            if (state is RecipesSelectionLoaded) {
              print('estado de carga exitosa pagina de recetas');
              recipeItems = state.recipeItems;
              print('recetas cargadas: $recipeItems');
            }

            if (state is RecipesSelectionError) {
              print('estado de error pagina de recetas');
            }

            return const Text('Recipes Selection Page');
          }
        ),
      ),
    );
  }
}