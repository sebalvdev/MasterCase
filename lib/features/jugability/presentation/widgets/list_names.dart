import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';

Widget names() {
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  final names = sharedPreferences.getStringList(cachePlayers) ?? [];

  return Stack(
    children: [
      if (names.isNotEmpty)
        Positioned(
          top: 10,
          left: 10,
          child: nameTile(names[0]),
        ),
      if (names.length > 1)
        Positioned(
          top: 10,
          right: 10,
          child: nameTile(names[1]),
        ),
      if (names.length > 2)
        Positioned(
          bottom: 10,
          right: 10,
          child: nameTile(names[2]),
        ),
    ],
  );
}

Widget nameTile(String name) {
  return Container(
    width: 100, // Ajusta el ancho según sea necesario
    height: 50,
    color: white,
    child: Center(
      child: Text(
        name,
        style: TextStyle(color: black, fontSize: h2),
      ),
    ),
  );
}
