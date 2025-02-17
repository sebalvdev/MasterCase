import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/config/routes/app_routes.dart';
import 'package:master_case/core/utilities/utilities.dart';
import 'package:master_case/features/recipes_selection/data/models/recipe_item_model.dart';
import 'package:master_case/features/recipes_selection/domain/entities/recipe_item.dart';
import 'package:master_case/features/recipes_selection/presentation/bloc/recipes_selection_bloc.dart';
import 'package:master_case/injection_container.dart';

class RecipesSelectionPage extends StatelessWidget {
  final List<String> recipes = [
    'Conjunto de recetas A',
    'Receta 2',
    'Receta 3',
    'Receta 4',
    'Receta 5',
    'Receta 6',
    'Receta 7',
    'Receta 8',
    'Receta 9'
  ];

  final Utilities utilities = Utilities();

  RecipesSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selección de recetas'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<RecipesSelectionBloc> buildBody(BuildContext context) {
    List<RecipeItem> recipeItems = [];
    Utilities utilities = Utilities();

    return BlocProvider(
      create: (context) => sl<RecipesSelectionBloc>(),
      child: Center(
        child: BlocBuilder<RecipesSelectionBloc, RecipesSelectionState>(
            builder: (context, state) {
          if (state is RecipesSelectionInitial) {
            BlocProvider.of<RecipesSelectionBloc>(context)
                .add(GetRecipesEvent());
            print('estado inicial pagina de recetas');
          }

          if (state is RecipesSelectionLoading) {
            print('estado de carga pagina de recetas');
          }

          if (state is RecipesSelectionLoaded) {
            recipeItems = state.recipeItems;
            // String nombresRestaurantes = utilities.getPlayersRestaurantNames();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  //todo: esto en un futuro podra admitir recetas personalizadas
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => _showRecipeDialog(context),
                      borderRadius: BorderRadius.circular(10), // Efecto de clic redondeado
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, 
                            vertical: 5
                        ),
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/conjuntoComidasA.png',
                                width: 200, // Ajusta el tamaño de la imagen
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  recipes[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }

          if (state is RecipesSelectionError) {
            // print('estado de error pagina de recetas');
          }

          return const Text('Recipes Selection Page');
        }),
      ),
    );
  }

  void _showRecipeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Conjunto de recetas A'),
            content: const Text(
              'Empezaras la partida con el conjunto de recetas A',
              textAlign: TextAlign.center,  
            ),
            actions: [
              FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    List<RecipeItemModel> inGameRecipesList = utilities.getCacheSavedRecipes();
                    utilities.setInGameRecipesGroup(inGameRecipesList);
                    Navigator.popAndPushNamed(context, AppRoutes.globalEvent);
                  },
                  child: const Text('Empezar juego'))
            ],
          );
        });
  }
}
