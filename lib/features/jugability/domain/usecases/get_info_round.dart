import 'package:dartz/dartz.dart';
import 'package:master_case/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/round_info.dart';
import '../repositories/jugability_repository.dart';

class GetInfoRound implements UseCase<RoundInfo, NoParams>{
  final JugabilityRepository repository;

  GetInfoRound({required this.repository});


  @override
  Future<Either<Failure, RoundInfo>> call(NoParams params) async {
    return await repository.getInfoRound();
  }
}

// class Params extends Equatable {
//   final Map<String, dynamic> data;

//   const Params({required this.data});
  
//   @override
//   List<Object?> get props => [];
// }