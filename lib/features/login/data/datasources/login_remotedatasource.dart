// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';

abstract class LoginRemoteDataSource {
  Future<String> loginDevice(Map<String, dynamic> data);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
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
          // .doc(boxId)
          .doc(boxIdTest)
          .collection(users)
          .get();

      for (var doc in snapshot.docs) {
        final docData = doc.data();
        if (docData['ci'] == data['ci'] ||
            docData['phone_number'] == data['number']
            //  || docData['device'] == deviceInfo.fingerprint
            ) {
          return 'Datos ya registrados';
        }
      }

      // if (snapshot.size < maxDevices) {
        Map<String, dynamic> info = {
          'ci': data['ci'],
          'phone_number': data['number'],
          'device': deviceInfo.fingerprint
        };
        await firebaseFirestore
            .collection(gamesTable)
            .doc(masterCase)
            .collection(boxesColection)
            // .doc(boxId)
            .doc(boxIdTest)
            .collection(users)
            .add(info);

        return 'success';
      // } else {
      //   // ! Mensaje cuando los dispositivos estan llenos
      //   return 'devices_full';
      // }
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
