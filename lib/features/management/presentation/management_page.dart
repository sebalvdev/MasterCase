import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:master_case/core/utilities/utilities.dart';

class ManagementPage extends StatefulWidget {
  ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  Utilities utilities = Utilities();

  @override
  void initState() {
    super.initState();
    // Forzar orientación a vertical al entrar en la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Restaurar orientación a predeterminada al salir de la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Management Page'),
      ),
      body: Column(
        children: [
          Text('Ventas durante el mes de ${utilities.getCurrentMonth()}'),
          Expanded(child: Image.asset('assets/images/estatistics.png')),
          statistics(),
          FilledButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                  title: const Text('Preparate para comenzar el siguiente mes'),
                  actions: [
                    TextButton(
                      onPressed: () {}, 
                      child: const Text('Cancelar')
                    ),
                    TextButton(
                      onPressed: () {
                        print('el siguiente mes comenzo');
                      }, 
                      child: const Text('Comenzar')
                    )
                  ],
                )
              );
            }, 
            child: const Text('Comenzar siguiente mes'),
          ),
        ],
      ),
    );
  }

  Widget statistics() {
    return const Column(
      children: [
        Text('Restaurant 1 ........................ 10'),
        Text('Restaurant 2 ........................ 20'),
        Text('Restaurant 3 ........................ 30'),
      ],
    );
  }
}
