import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import 'menu_buttons.dart';

class LateralMenu extends StatefulWidget {
  final BuildContext context;

  const LateralMenu({super.key, required this.context});

  @override
  // ignore: library_private_types_in_public_api
  _LateralMenuState createState() => _LateralMenuState();
}

class _LateralMenuState extends State<LateralMenu> {
  Map<String, dynamic> userInfo = {};
  String selectedAvatar = "";

  // Cargar todos los recursos necesarios, como la imagen, antes de construir el widget
  Future<void> _loadResources() async {
    await precacheImage(const AssetImage('assets/images/reverso.png'), context);
    // Puedes cargar otros recursos aquí si es necesario
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadResources(),
      builder: (context, snapshot) {
        // Muestra un indicador de carga mientras se esperan los recursos
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(color: white,));
        }

        // Construye el Drawer una vez que los recursos están cargados
        return Drawer(
          backgroundColor: white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(height: 30),
              buttons(context),
            ],
          ),
        );
      },
    );
  }
}
