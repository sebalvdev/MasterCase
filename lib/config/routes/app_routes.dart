import 'package:flutter/material.dart';
import 'package:master_case/features/management/presentation/pages/management_page.dart';

import '../../features/extra_pages/presentation/pages/credits_page.dart';
import '../../features/extra_pages/presentation/pages/instructions_page.dart';
import '../../features/global_event/presentation/pages/global_event_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/jugability/presentation/pages/finish_page.dart';
import '../../features/jugability/presentation/pages/jugability_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/menu/presentation/pages/menu_page.dart';
import '../../features/name_players/presentation/pages/name_players_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/recipes_selection/presentation/pages/recipe_selection_info_page.dart';
import '../../features/recipes_selection/presentation/pages/recipes_selection_page.dart';
import '../../features/scanner_qr/presentation/pages/qr_scanner_page.dart';
import '../../features/suppliers/presentation/pages/suppliers_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String qrScanner = '/qr_scanner';
  static const String menu = '/menu';
  static const String namePlayers= '/name_players';
  static const String game = '/game';
  static const String instruction = '/instruction';
  static const String credits = '/credits';
  static const String gameOver = '/game_over';
  static const String recipeSelection = '/recipe_selection';
  static const String globalEvent = '/global_event';
  static const String recipeSelectionInfo = '/recipe_selection_info';
  static const String ingredientSuppliers = '/ingredient_suppliers';
  static const String orders = '/orders';
  static const String management = '/management';

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
        return _materialRoute(MenuPage());
      case namePlayers:
        final int numberPlayers = int.parse(settings.arguments as String);
        return _materialRoute(NamePlayersPage(numberPlayers: numberPlayers,));
      case game:
        return _materialRoute(JugabilityPage());
      case instruction:
        return _materialRoute(const InstructionsPage());
      case credits:
        return _materialRoute(const CreditsPage());
      case gameOver:
        return _materialRoute(const FinishPage());
      case recipeSelection:
        return _materialRoute(RecipesSelectionPage());
      case globalEvent:
        return _materialRoute(GlobalEventPage());
      case recipeSelectionInfo:
        return _materialRoute(const RecipeSelectionInfoPage());
      case ingredientSuppliers:
        return _materialRoute(const SuppliersPage());
      case orders:
        return _materialRoute(const OrdersPage());
      case management:
        return _materialRoute(const ManagementPage());

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
