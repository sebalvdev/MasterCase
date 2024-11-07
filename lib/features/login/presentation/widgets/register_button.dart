// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';

void createAccount(
  BuildContext context,
  String number,
  String ci,
) {
  try {
    // print("$name, $number, $gender, $age, $ci");
    BlocProvider.of<LoginBloc>(context).add(RegisterEvent(data: {
      'number': number,
      'ci': ci,
    }));
  } catch (e) {
    print("Error al recibir datos: $e");
  }
}
