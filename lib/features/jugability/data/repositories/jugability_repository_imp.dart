import 'package:dartz/dartz.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import '../../../login/data/datasources/login_remotedatasource.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/round_info.dart';
import '../../domain/repositories/jugability_repository.dart';
import '../datasource/jugability_localdatasource.dart';

class JugabilityRepositoryImpl implements JugabilityRepository{
  final JugabilityLocalDataSource localDataSource;
  // final LoginRemoteDataSource remoteDataSource;
  bool connection = false;

  JugabilityRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, RoundInfo>> getInfoRound() async {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    await sharedPreferences.setString(cacheLastMonth, 'Enero');
    
    try {
      RoundInfo result = RoundInfo(calories: 0, taxes: 0, month: 'month', meals: []);
      // connection = await InternetConnection().hasInternetAccess;
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
  
  @override
  Future<Either<Failure, RoundInfo?>> nextInfoRound(String month) async {    
    try {
      RoundInfo? result = RoundInfo(calories: 0, taxes: 0, month: 'month', meals: []);
      // connection = await InternetConnection().hasInternetAccess;
      // if (connection) {
      //   result = await remoteDataSource.getInfoRound();
      //   return Future.value((right(result)));
      // } else {
      //   result = await localDataSource.getInfoRound();
      //   return Future.value((right(result)));
      // }
        result = await localDataSource.nextInfoRound(month);
        return Future.value((right(result)));
    } on CacheFailure {
      return Future.value(left(CacheFailure()));
    } on UnknownFailure {
      return Future.value(left(UnknownFailure()));
    }
  }
}