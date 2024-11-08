import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:master_case/features/scanner_qr/domain/usecases/validate_qr_code.dart' as validate_qr_code;

part 'scanner_qr_event.dart';
part 'scanner_qr_state.dart';

class ScannerQrBloc extends Bloc<ScannerQrEvent, ScannerQrState> {

  final validate_qr_code.ValidateQrCode validateQrCode;

  ScannerQrBloc({required this.validateQrCode}) : super(ScannerQrInitial()) {
    on<ValidateQRCodeEvent>((event, emit) async {
      emit(ScannerQrLoading());
      final result = await validateQrCode.call(validate_qr_code.Params(outsideQRCode: event.outsideQRCode));
      result.fold(
        (failure) => emit(const ScannerQrError(message: 'Error validating QR code')),
        (isQrCodeValidated) => emit(OutsideQrCodeValidated(isQrCodeValidated: isQrCodeValidated))
      );
    });
  }
}
