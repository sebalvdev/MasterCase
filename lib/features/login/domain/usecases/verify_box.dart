import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/login_repository.dart';

class VerifyDevice implements UseCase<String, Params> {
  final LoginRepository repository;

  VerifyDevice({required this.repository});

  @override
  Future<Either<Failure, String>> call(params) async {
    return await repository.loginDevice(params.data);
  }
}

class Params extends Equatable {
  final Map<String, dynamic> data;

  const Params({required this.data});
  
  @override
  List<Object?> get props => [];
}
