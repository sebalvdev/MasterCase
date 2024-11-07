import 'package:flutter/material.dart';
import 'package:master_case/config/routes/app_routes.dart';

import '../../../../core/constants/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: white),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        Text(
                          'Bienvenido a la aplicacion de MASTER CASE',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: h2),
                        ),
                        Text(
                          'a continuacion registraras tu dispositivo para poder jugar el juego, asegurate de no sobrepasar el numero maximo de dispositivos registrados.\nEste registro solo sera realizado la primera vez que entres al juego.',
                          style: TextStyle(fontSize: h2),
                        ),
                        ElevatedButton(onPressed: () => Navigator.popAndPushNamed(context, AppRoutes.login), child: const Text('Continuar', textAlign: TextAlign.center,))
                      ],
                    ),
                  ),
                  // const SizedBox(width: 250, child: Image(image: NetworkImage('https://picsum.photos/250'), fit: BoxFit.contain,)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
