part of 'scanner_qr_bloc.dart';

sealed class ScannerQrState extends Equatable {
  const ScannerQrState();
  
  @override
  List<Object> get props => [];
}

final class ScannerQrInitial extends ScannerQrState {}

final class ScannerQrLoading extends ScannerQrState {}

final class OutsideQrCodeValidated extends ScannerQrState {
  final bool isQrCodeValidated;

  const OutsideQrCodeValidated({required this.isQrCodeValidated});

  @override
  List<Object> get props => [isQrCodeValidated];
}

final class ScannerQrError extends ScannerQrState {
  final String message;

  const ScannerQrError({required this.message});

  @override
  List<Object> get props => [message];
}
