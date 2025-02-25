import 'package:flutter/material.dart';
import 'package:master_case/core/constants/color_constants.dart';
import 'package:master_case/features/orders/presentation/widgets/lateral_menu_buttons.dart';

class LateralOrderMenu extends StatefulWidget {
  final BuildContext context;
  const LateralOrderMenu({super.key, required this.context});

  @override
  State<LateralOrderMenu> createState() => _LateralMenuState();
}

class _LateralMenuState extends State<LateralOrderMenu> {

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
              lateralMenuButtons(context),
            ],
          ),
        );
      },
    );
  }
}