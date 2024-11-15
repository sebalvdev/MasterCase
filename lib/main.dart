import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:master_case/core/utilities/utilities.dart';
import 'package:master_case/features/menu/presentation/pages/menu_page.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/default_theme.dart';
import 'features/welcome_screen/presentation/pages/welcome_page.dart';
import 'firebase_options.dart';

import 'injection_container.dart' as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Utilities utilities = Utilities();
    bool userLogged = utilities.isUserLogged();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      title: 'Master Case App',
      theme: defaultTheme(),
      // tiene que mostrarse directamente la pagina de cocina si esta logueado
      home: userLogged ? MenuPage() : const WelcomePage(),
    );
  }
}
