import 'package:dartz/dartz.dart';
import 'package:master_case/core/error/failures.dart';
import 'package:master_case/core/network/network_info.dart';
import 'package:master_case/features/scanner_qr/data/datasources/scanner_qr_remote_datasource.dart';
import 'package:master_case/features/scanner_qr/domain/repositories/scanner_qr_repository.dart';

class ScannerQrRepositoryImpl implements ScannerQrRepository {

  final ScannerQrRemoteDataSource scannerQrRemoteDataSource;
  final NetworkInfo networkInfo;

  ScannerQrRepositoryImpl({
    required this.scannerQrRemoteDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, bool>> validateQRCode(String qrCode) async{
    if (await networkInfo.isConnected) {
      try {
        final outsideQRCodeValidation = await scannerQrRemoteDataSource.validateQRCode(qrCode);
        return Right(outsideQRCodeValidation);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

}