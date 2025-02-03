// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:master_case/core/constants/color_constants.dart';

class UniqueValue extends StatefulWidget {
  const UniqueValue({super.key});

  @override
  State<UniqueValue> createState() => _UniqueValueState();
}

class _UniqueValueState extends State<UniqueValue> {
  Future<String> getMetaData() async {
    String result = '';
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      result = deviceInfo.fingerprint;

    print(deviceInfo.fingerprint);
    } catch (e) {
      print(e);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getMetaData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras se obtiene el identificador
          return const CircularProgressIndicator(color: white,);
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si ocurre un problema
          return const Text('Error al obtener el identificador');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Muestra un mensaje si no se pudo obtener ningún dato
          return const Text('No se pudo obtener el identificador');
        } else {
          // Muestra los datos del identificador en un widget Text
          return Text('Identificador: ${snapshot.data}');
        }
      },
    );
  }
}
