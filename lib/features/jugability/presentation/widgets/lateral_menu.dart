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

  @override
  Widget build(BuildContext context) {
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
  }
}
