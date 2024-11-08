import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/scanner_qr_repository.dart';

class ValidateQrCode implements UseCase<bool, Params>{
  
  final ScannerQrRepository repository;

  ValidateQrCode({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.validateQRCode(params.outsideQRCode);
  }

}

class Params {
  final String outsideQRCode;

  Params({required this.outsideQRCode});
}