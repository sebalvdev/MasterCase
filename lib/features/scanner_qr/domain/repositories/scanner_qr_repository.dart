import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ScannerQrRepository {
  Future<Either<Failure, bool>> validateQRCode(String qrCode);
}