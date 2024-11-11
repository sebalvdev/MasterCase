import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:master_case/config/routes/app_routes.dart';

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
                text: 'Instrucciones',
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
                  // Navigator.popAndPushNamed(context, AppRoutes.game);
                },
                width: 200,
                height: 50,
                backColor: orange,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              // child: durationInput(200, 50),
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
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   // child: durationInput(200, 50),
            //   child: CustomDropdownButton(
            //     width: 200,
            //     height: 50,
            //     hintText: 'Jugadores',
            //     items: const ['Tres', 'Cuatro'],
            //     color: orange,
            //     dropdownColor: orange,
            //     textColor: black,
            //     fontSize: h2,
            //     onChanged: (String? newValue) {
            //       playersController = newValue;
            //     },
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Container durationInput(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: orange,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: DropdownButtonFormField<String>(
          iconEnabledColor: black,
          decoration: const InputDecoration(
            hintText: null, // Eliminamos el hintText de aquí
            border: InputBorder.none,
          ),
          hint: Center(
            // Usamos Center para alinear el hint en el centro
            child: Text(
              "Duración",
              style: TextStyle(color: black, fontSize: h2),
              textAlign: TextAlign.center,
            ),
          ),
          value: durationControler,
          dropdownColor: orange,
          items: <String>['Año completo', 'Medio año'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                // También centramos las opciones del menú
                child: Text(
                  value,
                  style: TextStyle(color: black, fontSize: h2),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            durationControler = newValue;
          },
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
