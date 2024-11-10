import 'package:flutter/material.dart';
import 'package:master_case/features/scanner_qr/presentation/pages/qr_scanner_page.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/menu/presentation/pages/menu_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String qrScanner = '/qr_scanner';
  static const String menu = '/menu';

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return _materialRoute(const HomePage());
      case home:
        return _materialRoute(const HomePage());
      case login:
        return _materialRoute(LoginPage());
      case qrScanner:
        return _materialRoute(const QRScannerPage());
      case menu:
        return _materialRoute(const MenuPage());
      // case eventHome:
      //   if (settings.arguments is Map<String, dynamic>) {
      //     final args = settings.arguments as Map<String, dynamic>;
      //     return _materialRoute(EventHomePage(eventInfo: args));
      //   }
      //   return _materialRoute(
      //       const EventHomePage(eventInfo: <String, dynamic>{}));
      // case qrScanner:
        // return _materialRoute(const QRScannerPage());
      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
