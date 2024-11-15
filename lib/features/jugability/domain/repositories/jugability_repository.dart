import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/round_info.dart';

abstract class JugabilityRepository {
  Future<Either<Failure, RoundInfo>> getInfoRound();
  Future<Either<Failure, RoundInfo?>> nextInfoRound(String month);
}