import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/primeraOpcionFondoWelcome.png', // Asegúrate de tener esta imagen en tu carpeta de assets
              fit: BoxFit.cover,
            ),
          ),
          // Contenido en la parte inferior
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.6), // Fondo semitransparente
            // padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 50),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 6),
                    const Text(
                      'APRENDE A JUGAR',
                      style: TextStyle(
                        color: Color.fromARGB(255, 227, 236, 68),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3 * 2,
                      child: const Text(
                        'Para aprender a jugar sigue las siguientes instrucciones',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    // Reglas del juego
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Define la duracion del juego.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset(
                          'assets/images/help/duracion.jpeg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Ponle nombre a tus emprendimientos.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset(
                          'assets/images/help/nombres.jpeg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'dale vuelta a los platos que vendes para ganar dinero',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset(
                          'assets/images/help/cards.jpeg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: Colors.transparent,
        child: const Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 227, 236, 68),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
