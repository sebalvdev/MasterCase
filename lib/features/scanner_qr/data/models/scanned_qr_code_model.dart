import 'package:master_case/features/scanner_qr/domain/entities/scanned_qr_code.dart';

class ScannedQrCodeModel extends ScannedQrCode{
  const ScannedQrCodeModel({
    required super.qrCode, 
    required super.scannedAt, 
    required super.validQrCode
  });

  factory ScannedQrCodeModel.fromJson(Map<String, dynamic> json){
    return ScannedQrCodeModel(
      qrCode: json['qrCode'],
      scannedAt: DateTime.parse(json['scannedAt']),
      validQrCode: json['validQrCode']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'qrCode': qrCode,
      'scannedAt': scannedAt.toIso8601String(),
      'validQrCode': validQrCode
    };
  }
}