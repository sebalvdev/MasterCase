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
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/primeraOpcionFondoWelcome.png',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // color: Colors.black.withOpacity(0.6),
            color: white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Juego Finalizado',
                    style: TextStyle(color: white),
                  ),
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
                          backColor: yellow,
                          textColor: black,
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
                          backColor: black,
                          textColor: white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
