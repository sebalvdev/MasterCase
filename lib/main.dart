import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:master_case/features/scanner_qr/presentation/pages/mobile_scanner_example.dart';
import 'package:master_case/features/scanner_qr/presentation/pages/qr_scanner_page.dart';
import 'package:master_case/features/scanner_qr/presentation/widgets/scanner_qr_widget.dart';
import 'package:master_case/features/welcome_screen/presentation/pages/welcome_page.dart';
import 'package:master_case/firebase_options.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/default_theme.dart';
import 'features/home/presentation/pages/home_page.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      title: 'Master Case App',
      theme: defaultTheme(),
      home: const WelcomePage(),
    );
  }
}
