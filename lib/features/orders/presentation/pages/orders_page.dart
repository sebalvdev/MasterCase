import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        print('PopScope result: $result');
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
          ),
          body: Builder(
            builder: (context) => const Center(
              child: Text('Contenido de la página de pedidos'),
            ),
          ),
        ),
      ),
    );
  }
}
