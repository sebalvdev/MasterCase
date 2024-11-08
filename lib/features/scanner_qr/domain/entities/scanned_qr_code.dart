import 'package:equatable/equatable.dart';

class ScannedQrCode extends Equatable {
  final String qrCode;
  final DateTime scannedAt;
  final bool validQrCode;

  const ScannedQrCode({
    required this.qrCode,
    required this.scannedAt,
    required this.validQrCode,
  });

  @override
  List<Object> get props => [qrCode, scannedAt, validQrCode];

}