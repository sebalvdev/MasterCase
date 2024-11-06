import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static const String home = '/';
  // static const String eventHome = '/event_home';
  // static const String qrScanner = '/qr_scanner';

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _materialRoute(const HomePage());
      // case eventHome:
      //   if (settings.arguments is Map<String, dynamic>) {
      //     final args = settings.arguments as Map<String, dynamic>;
      //     return _materialRoute(EventHomePage(eventInfo: args));
      //   }
      //   return _materialRoute(
      //       const EventHomePage(eventInfo: <String, dynamic>{}));
      // case qrScanner:
      //   return _materialRoute(const QRScannerPage());
      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
