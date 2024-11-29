import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';

Widget names() {
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  final names = sharedPreferences.getStringList(cachePlayers) ?? [];

  return Stack(
    children: [
      if (names.isNotEmpty)
        Positioned(
          bottom: 10,
          left: 10,
          // child: Transform.rotate(angle: math.pi, child: nameTile(names[0])),
          child: nameTile(names[0]),
        ),
      if (names.length > 1)
        Positioned(
          top: 10,
          right: 10,
          child: Transform.rotate(angle: math.pi, child: nameTile(names[1])),
          // child: nameTile(names[1]),
        ),
      if (names.length > 2)
        Positioned(
          bottom: 10,
          right: 10,
          // child: Transform.rotate(angle: math.pi, child: nameTile(names[2])),
          child: nameTile(names[2]),
        ),
    ],
  );
}

Widget nameTile(String name) {
  return Container(
    decoration:
        BoxDecoration(color: yellow, borderRadius: BorderRadius.circular(10)),
    width: 150, // Ajusta el ancho según sea necesario
    height: 50,
    child: Center(
      child: Text(
        name,
        style: TextStyle(color: black, fontSize: h1),
      ),
    ),
  );
}
