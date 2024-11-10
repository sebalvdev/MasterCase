
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:master_case/core/error/failures.dart';

import '../../domain/repositories/login_repository.dart';
import '../datasources/login_localdatasouce.dart';
import '../datasources/login_remotedatasource.dart';

class LoginRepositoryImpl extends LoginRepository{
  final LoginLocalDataSource localDataSource;
  final LoginRemoteDataSource remoteDataSource;  
  bool connection = false;

  LoginRepositoryImpl({required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> loginDevice(Map<String, dynamic> data) async {
    try {
      String result = '';
      connection = await InternetConnection().hasInternetAccess;
      if (connection) {
        result = await remoteDataSource.loginDevice(data);
        return Future.value((right(result)));
      } else {
        return Future.value((right('Debe tener conexion a internet')));
      }
    } on CacheFailure {
      return Future.value(left(CacheFailure()));
    } on UnknownFailure {
      return Future.value(left(UnknownFailure()));
    }
  }
}