import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';
import '../constants/constants.dart';

class Utilities {
  FirebaseFirestore firebaseFirestore = sl<FirebaseFirestore>();
  SharedPreferences sharedPreferences = sl<SharedPreferences>();

  Future<void> setCacheData(String metaData) async {
    await sharedPreferences.setString(cacheUserRegistered, metaData);
    await sharedPreferences.setBool(cacheFlagRegistered, true);
  }

  String getDeviceData() {
    return sharedPreferences.getString(cacheUserRegistered) ?? "Error";
  }

  bool getFlagRegistered() {
    return sharedPreferences.getBool(cacheFlagRegistered) ?? false;
  }

  Future<bool> registeredDevice() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;

      final snapshot = await firebaseFirestore
          .collection(gamesTable)
          .doc(masterCase)
          .collection(boxesColection)
          .doc(boxIdTest)
          .collection(users)
          .get();

      for (var doc in snapshot.docs) {
        final docData = doc.data();
        print('informacion del dispositivo: ${docData['device']} - ${deviceInfo.fingerprint}');
        if (docData['device'] == deviceInfo.fingerprint) {
          return true;
        }
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return false; // Retorna falso si no encuentra el dispositivo
  }

  void setUserLogged() {
    sharedPreferences.setBool(cacheUserLogged, true);
  }

  bool isUserLogged() {
    return sharedPreferences.getBool(cacheUserLogged) ?? false;
  }
}
