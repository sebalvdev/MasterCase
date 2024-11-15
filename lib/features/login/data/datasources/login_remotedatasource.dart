// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../injection_container.dart';
import '../model/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<String> loginDevice(Map<String, dynamic> data);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  Utilities utilities = Utilities();
  FirebaseFirestore firebaseFirestore = sl<FirebaseFirestore>();
  SharedPreferences sharedPreferences = sl<SharedPreferences>();

  @override
  Future<String> loginDevice(Map<String, dynamic> data) async {
    try {
      // String boxId = sharedPreferences.getString(cacheBoxId)!;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      // final maxDevices = await setMaxDevices();

      final snapshot = await firebaseFirestore
          .collection(gamesTable)
          .doc(masterCase)
          .collection(boxesColection)
          .get();

      // Verificar si los datos ya existen en algún documento
      for (var doc in snapshot.docs) {
        final docData = doc.data();
        if (docData['ci'] == data['ci'] &&
            docData['phone_number'] == data['phone_number']) {
          // Guardar en caché y retornar éxito
          // return 'Datos no encontrados en la colección';
          return 'success';
        }
      }
      data['device'] = deviceInfo.fingerprint;
      await setUserInfoToCache(data);

      utilities.setCacheData(deviceInfo.fingerprint);

      return 'success';
    } catch (e) {
      print('Error en el registro de datos: $e');
      return '$e';
    }
  }

  // Future<int> setMaxDevices() async {
  //   try {
  //     final snapshot =
  //         await firebaseFirestore.collection(gamesTable).doc(masterCase).get();
  //     final data = snapshot.data();
  //     final max = data?['max_devices'] ?? 3;

  //     sharedPreferences.setInt(cacheMaxDevices, max);
  //     return max;
  //   } catch (e) {
  //     print('Error en obtener max: $e');
  //     return 3;
  //   }
  // }

  // int getMaxDevices() {
  //   try {
  //     final max = sharedPreferences.getInt(cacheMaxDevices)!;
  //     return max;
  //   } catch (e) {
  //     print('Error en obtener max devices: $e');
  //     return 3;
  //   }
  // }
}
