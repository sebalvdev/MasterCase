import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:master_case/features/extra_pages/presentation/pages/test_page.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../bloc/menu_bloc.dart';
import '../widgets/custom_dropdown_button.dart';
import '../widgets/widgets.dart';

// ignore: must_be_immutable
class MenuPage extends StatelessWidget {
  MenuPage({super.key});
  String? durationControler;
  String? playersController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const TestPage(),
      //       )),
      // ),
    );
  }

  BlocProvider<MenuBloc> content() {
    return BlocProvider(
      create: (context) => sl<MenuBloc>(),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuInitial) {
            context.read<MenuBloc>().add(LoadMenuEvent());
          }
          if (state is MenuLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MenuLoaded) {
            return buildForm(context);
          }
          if (state is SecondMenuLoaded) {
            return secondbuildForm(context);
          }
          if (state is GetNames) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.popAndPushNamed(context, AppRoutes.namePlayers,
                  arguments: playersController);
            });
          }

          return const Center(child: CircularProgressIndicator());
          // return const Center(
          //   child: Text('Error en la carga del menu'),
          // );
        },
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height / 4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(onPressed: () {}, child: const Text('opciones'),),
            SizedBox(
              height: screenHeight,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'jugar',
                function: () {
                  context.read<MenuBloc>().add(LoadSecondMenuEvent());
                },
                backColor: green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Instrucciones',
                function: () async {
                  Navigator.pushNamed(context, AppRoutes.instruction);
                },
                backColor: green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'creditos',
                function: () {
                  Navigator.pushNamed(context, AppRoutes.credits);
                },
                backColor: green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget secondbuildForm(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              text: 'volver',
              function: () => context.read<MenuBloc>().add(LoadMenuEvent()),
              width: 100,
              height: 50,
              backColor: orange,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomDropdownButton(
                  width: 200,
                  height: 50,
                  hintText: 'Duracion',
                  items: const ['Año completo', 'Medio año'],
                  color: orange,
                  dropdownColor: orange,
                  textColor: black,
                  fontSize: h2,
                  onChanged: (String? newValue) {
                    durationControler = newValue;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomDropdownButton(
                  width: 200,
                  height: 50,
                  hintText: 'Jugadores',
                  items: const ['2', '3'],
                  color: orange,
                  dropdownColor: orange,
                  textColor: black,
                  fontSize: h2,
                  onChanged: (String? newValue) {
                    playersController = newValue;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  text: 'jugar',
                  function: () => verifyValues(context),
                  width: 200,
                  height: 50,
                  backColor: orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void verifyValues(BuildContext context) {
    if (durationControler != null && playersController != null) {
      context.read<MenuBloc>().add(GetNamesEvent(
          duration: (durationControler == 'Año completo') ? 1 : 0.5,
          players: int.parse(playersController!)));
    } else {
      _showSnackBar(context, "Debe llenar todos los campos.");
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
