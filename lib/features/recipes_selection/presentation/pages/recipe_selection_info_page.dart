import 'package:flutter/material.dart';
import 'package:master_case/config/routes/app_routes.dart';
import 'package:master_case/core/constants/color_constants.dart';

class RecipeSelectionInfoPage extends StatelessWidget {
  const RecipeSelectionInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/fondoAbstractoRotado.jpg', // Asegúrate de tener esta imagen en tus assets
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Oscurece un poco la imagen para mayor legibilidad
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'A continuación, cada jugador tendrá que escoger una cantidad de recetas que estarán presentes durante la partida.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón
                  Navigator.pushNamed(context, AppRoutes.recipeSelection);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: yellow,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Comenzar selección de recetas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}