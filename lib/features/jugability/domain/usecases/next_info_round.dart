import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:master_case/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/round_info.dart';
import '../repositories/jugability_repository.dart';

class NextInfoRound implements UseCase<RoundInfo?, Params>{
  final JugabilityRepository repository;

  NextInfoRound({required this.repository});

  @override
  Future<Either<Failure, RoundInfo?>> call(Params params) async {
    return await repository.nextInfoRound(params.month);
  }
}

class Params extends Equatable {
  final String month;

  const Params({required this.month});
  
  @override
  List<Object?> get props => [];
}