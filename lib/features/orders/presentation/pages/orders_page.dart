import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:master_case/core/constants/color_constants.dart';
import 'package:master_case/features/order_card/presentation/widgets/simple_timer.dart';

import '../../../order_card/presentation/pages/order_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return PopScope(
      canPop: false,
      onPopInvoked: (result) {
        // print('PopScope result: $result');
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Menú Lateral',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Inicio'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Configuraciones'),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text('Plataforma de Pedidos'),
            automaticallyImplyLeading: true, // Permite que el botón de menú se muestre
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: SimpleTimer(startSeconds: 20, fontSize: 25, textColor: black),
                // child: Text('Timer'),
              )
            ],
          ),
          body: Builder(
            builder: (context) => const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OrderCard(),
                  OrderCard(),
                  OrderCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
