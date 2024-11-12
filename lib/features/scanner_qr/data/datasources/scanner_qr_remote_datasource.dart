// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ScannerQrRemoteDataSource {
  Future<bool> validateQRCode(String qrCode);
}

class ScannerQrRemoteDataSourceImpl implements ScannerQrRemoteDataSource {
  final FirebaseFirestore firestore;

  ScannerQrRemoteDataSourceImpl({required this.firestore});

  @override
  Future<bool> validateQRCode(String qrCode) async {
    final boxID = await getBoxId(qrCode);
    print('Box ID: $boxID');

    if (await qrCodeExists(qrCode)) {
      final actualDevicesNumber = await checkDevicesNumber(qrCode);
      final gameRules = await firestore
          .collection('games')
          .doc('emXYuSuveWscid36xb65')
          .get();

      final maxDevicesNumber = gameRules.data()!['max_devices'];

      if (maxDevicesNumber == null) {
        return false; // O maneja el caso de acuerdo a tu lógica
      } else {
        if (actualDevicesNumber >= maxDevicesNumber) {
          return false;
        } else {
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
}
