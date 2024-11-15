// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_case/core/constants/cache_constants.dart';
import 'package:master_case/core/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ScannerQrRemoteDataSource {
  Future<bool> validateQRCode(String qrCode);
}

class ScannerQrRemoteDataSourceImpl implements ScannerQrRemoteDataSource {
  final FirebaseFirestore firestore;

  ScannerQrRemoteDataSourceImpl({required this.firestore});

  @override
  Future<bool> validateQRCode(String qrCode) async {
    final Utilities utilities = Utilities();
    final boxID = await getBoxId(qrCode);
    print('Box ID: $boxID');

    Map<String, dynamic>? userInfo = await getUserInfoFromCache();
    print('User Info: $userInfo');

    if (await qrCodeExists(qrCode)) {
      final actualDevicesNumber = await checkDevicesNumber(qrCode);
      final gameRules =
          await firestore.collection('games').doc('emXYuSuveWscid36xb65').get();

      final maxDevicesNumber = gameRules.data()!['max_devices'];

      if (maxDevicesNumber == null) {
        return false; // O maneja el caso de acuerdo a tu lógica
      } else {
        if (actualDevicesNumber >= maxDevicesNumber) {
          //si el numero de dispositivos es mayor o igual
          // al limite de dispositivos permitidos evalua si este dispositivo ya esta registrado
          if (await utilities.registeredDevice()) {
            saveUserInfoInFirebase(userInfo!, boxID);
            return true;
          } else {
            return false;
          }
        } else {
          saveUserInfoInFirebase(userInfo!, boxID);
          return true;
        }
      }
    } else {
      return false;
    }
  }

  Future<int> checkDevicesNumber(String qrCode) async {
    final boxID = await getBoxId(qrCode);
    final boxDevices = await firestore
        .collection('games')
        .doc('emXYuSuveWscid36xb65')
        .collection('boxes')
        .doc(boxID)
        .collection('users')
        .get();

    if (boxDevices.docs.isNotEmpty) {
      return boxDevices.docs.length;
    } else {
      return 0;
    }
  }

  Future<bool> qrCodeExists(String outsideQRCode) async {
    final box = await firestore
        .collection('games')
        .doc('emXYuSuveWscid36xb65')
        .collection('boxes')
        .get();

    bool existQRCode = false;

    if (box.docs.isNotEmpty) {
      for (var doc in box.docs) {
        final String firebaseQRCode = doc.data()['qr_code'];
        if (outsideQRCode == firebaseQRCode) {
          existQRCode = true;
          break;
        }
      }
    }
    return existQRCode;
  }

  Future<String> getBoxId(String outsideQRCode) async {
    final box = await firestore
        .collection('games')
        .doc('emXYuSuveWscid36xb65')
        .collection('boxes')
        .get();

    String boxId = '';

    if (box.docs.isNotEmpty) {
      for (var doc in box.docs) {
        final String firebaseQRCode = doc.data()['qr_code'];
        if (outsideQRCode == firebaseQRCode) {
          boxId = doc.id;
          break;
        }
      }
    }
    return boxId;
  }

  Future<Map<String, dynamic>?> getUserInfoFromCache() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    String? dataJson = sharedPreferences.getString(cacheUserInfo);

    if (dataJson != null) {
      return jsonDecode(dataJson) as Map<String, dynamic>;
    }

    return null;
  }

  Future<void> saveUserInfoInFirebase(Map<String, dynamic> data, String boxID) async {
    Map<String, dynamic>? userInfo = data;

    if (userInfo.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('games')
          .doc('emXYuSuveWscid36xb65')
          .collection('boxes')
          .doc(boxID)
          .set(data, SetOptions(merge: true)); // Usa merge para evitar sobrescribir datos existentes.
      print("Datos subidos correctamente a Firestore.");
    }
  }
}
