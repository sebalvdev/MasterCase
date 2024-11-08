import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../bloc/menu_bloc.dart';
import '../widgets/widgets.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: content());
  }

  BlocProvider<MenuBloc> content() {
    return BlocProvider(
      create: (context) => sl<MenuBloc>(),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MenuLoaded) {
            return buildForm(context);
          }
          if (state is SecondMenuLoaded) {
            return secondbuildForm(context);
          }
          if (state is MenuInitial) {
            context.read<MenuBloc>().add(LoadMenuEvent());
          }
          return const Center(
            child: Text('Error en la carga del menu'),
          );
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
                width: 200,
                height: 50,
                backColor: green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'opciones',
                function: () {},
                width: 200,
                height: 50,
                backColor: green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'creditos',
                function: () {},
                width: 200,
                height: 50,
                backColor: green,
              ),
            ),
            // ElevatedButton(onPressed: () {}, child: const Text('creditos'),),
          ],
        ),
      ],
    );
  }

  Widget secondbuildForm(BuildContext context) {
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
                  context.read<MenuBloc>().add(LoadMenuEvent());
                },
                width: 200,
                height: 50,
                backColor: orange,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'opciones',
                function: () {},
                width: 200,
                height: 50,
                backColor: orange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
