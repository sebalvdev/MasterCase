import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:master_case/core/error/failures.dart';

import 'package:master_case/features/jugability/domain/entities/round_info.dart';

// import '../../../login/data/datasources/login_remotedatasource.dart';
import '../../domain/repositories/jugability_repository.dart';
import '../datasource/jugability_localdatasource.dart';

class JugabilityRepositoryImpl implements JugabilityRepository{
  final JugabilityLocalDataSource localDataSource;
  // final LoginRemoteDataSource remoteDataSource;
  bool connection = false;

  JugabilityRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, RoundInfo>> getInfoRound() async {
    try {
      RoundInfo result = RoundInfo(calories: 0, taxes: 0, month: 'month', meals: []);
      connection = await InternetConnection().hasInternetAccess;
      // if (connection) {
      //   result = await remoteDataSource.getInfoRound();
      //   return Future.value((right(result)));
      // } else {
      //   result = await localDataSource.getInfoRound();
      //   return Future.value((right(result)));
      // }
        result = await localDataSource.getInfoRound();
        return Future.value((right(result)));
    } on CacheFailure {
      return Future.value(left(CacheFailure()));
    } on UnknownFailure {
      return Future.value(left(UnknownFailure()));
    }
  }
}