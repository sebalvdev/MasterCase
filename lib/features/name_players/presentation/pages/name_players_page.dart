import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../injection_container.dart';
import '../bloc/names_bloc.dart';
import '../widgets/widgets.dart';

// ignore: must_be_immutable
class NamePlayersPage extends StatelessWidget {

  Utilities utilities = Utilities();
  final int numberPlayers;

  NamePlayersPage({super.key, required this.numberPlayers});

  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondoAbstractoRotado.jpg',
              fit: BoxFit.cover,
            ),
          ),
          content(),
        ],
      ),
    );
  }

  BlocProvider<NamesBloc> content() {
    return BlocProvider(
      create: (context) => sl<NamesBloc>(),
      child: BlocBuilder<NamesBloc, NamesState>(
        builder: (context, state) {
          if (state is NamesInitial) {
            context.read<NamesBloc>().add(LoadNamesEvent());
          }

          if (state is NamesLoading) {
            return const Center(child: CircularProgressIndicator(color: white,));
          }

          if (state is NamesLoaded) {
            return buildForm(context);
          }

          if (state is StartGame) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.popAndPushNamed(context, AppRoutes.game);
            });
          }

          return const Center(child: CircularProgressIndicator(color: white,));
          // return const Center(
          //   child: Text('Error en la carga del nombres'),
          // );
        },
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height / 4;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(onPressed: () {}, child: const Text('opciones'),),
            // SizedBox(
            //   height: screenHeight,
            // ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomeInput(
                controller: nameController1,
                hintText: 'Restaurante 1',
                fontSize: h2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomeInput(
                controller: nameController2,
                hintText: 'Restaurante 2',
                fontSize: h2,
              ),
            ),
            if (numberPlayers != 2) ...{
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomeInput(
                  controller: nameController3,
                  hintText: 'Restaurante 3',
                  fontSize: h2,
                ),
              ),
            },
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Jugar',
                function: () {
                  controlNames(context);
                },
                backColor: yellow,
                textColor: black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Volver',
                function: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.menu,
                  (route) => false,
                ),
                backColor: black,
                textColor: white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void controlNames(BuildContext context) {
    final name1 = nameController1.text;
    final name2 = nameController2.text;
    final name3 = nameController3.text;

    if (numberPlayers != 2) {
      if (name1.isNotEmpty && name2.isNotEmpty && name3.isNotEmpty) {
        utilities.setNumberOfPlayers(numberPlayers);
        utilities.setRestaurantNames([name1, name2, name3]);
        //todo: cambiar el evento por uno que muestre la pantalla de escoger recetas
        // context.read<NamesBloc>().add(StartGameEvent(playerRestaurantNames: [name1, name2, name3]));
        // BlocProvider.of<RecipesSelectionBloc>(context).add(GetRecipesEvent());
         Navigator.pushNamed(context, AppRoutes.recipeSelection);
        
      } else {
        _showSnackBar(context, "Debe llenar todos los campos.");
      }
    } else {
      if (name1.isNotEmpty && name2.isNotEmpty) {
        utilities.setNumberOfPlayers(numberPlayers);
        utilities.setRestaurantNames([name1, name2, name3]);
        // context.read<NamesBloc>().add(StartGameEvent(playerRestaurantNames: [name1, name2]));
        // BlocProvider.of<RecipesSelectionBloc>(context).add(GetRecipesEvent());
        Navigator.pushNamed(context, AppRoutes.recipeSelection);
      } else {
        _showSnackBar(context, "Debe llenar todos los campos.");
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
