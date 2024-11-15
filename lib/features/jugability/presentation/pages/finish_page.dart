import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/constants.dart';
import '../widgets/widgets.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('FinishPage', style: TextStyle(color: white),),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                        text: 'Volver a jugar',
                        width: 200,
                        function: () {
                          returnToMenu(context);
                        },
                        backColor: green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                        text: 'Salir',
                        width: 200,
                        function: () {
                          returnToMenu(context);
                        },
                        backColor: red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void returnToMenu(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.menu,
        (route) => false,
      );
    });
  }
}