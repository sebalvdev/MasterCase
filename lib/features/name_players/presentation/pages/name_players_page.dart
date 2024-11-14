import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../bloc/names_bloc.dart';
import '../widgets/widgets.dart';

// ignore: must_be_immutable
class NamePlayersPage extends StatelessWidget {
  final int numberPlayers;
  NamePlayersPage({super.key, required this.numberPlayers});

  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
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
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NamesLoaded) {
            return buildForm(context);
          }

          if (state is StartGame) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.popAndPushNamed(context, AppRoutes.game);
            });
          }

          return const Center(child: CircularProgressIndicator());
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
                hintText: 'Jugador 1',
                fontSize: h2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomeInput(
                controller: nameController1,
                hintText: 'Jugador 2',
                fontSize: h2,
              ),
            ),
            if (numberPlayers != 2) ...{
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomeInput(
                  controller: nameController1,
                  hintText: 'Jugador 3',
                  fontSize: h2,
                ),
              ),
            },
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'jugar',
                function: () {
                  controlNames(context);
                },
                backColor: green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void controlNames(BuildContext context) {
    context.read<NamesBloc>().add(const StartGameEvent(players: []));
  }
}
