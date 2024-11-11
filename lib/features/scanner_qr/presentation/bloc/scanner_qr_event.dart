part of 'scanner_qr_bloc.dart';

sealed class ScannerQrEvent extends Equatable {
  const ScannerQrEvent();

  @override
  List<Object> get props => [];
}

class ValidateQRCodeEvent extends ScannerQrEvent {
  final String outsideQRCode;

  const ValidateQRCodeEvent({required this.outsideQRCode});

  @override
  List<Object> get props => [outsideQRCode];
}
