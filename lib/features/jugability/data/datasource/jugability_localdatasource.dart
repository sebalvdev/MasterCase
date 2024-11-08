import '../../domain/entities/round_info.dart';

abstract class JugabilityLocalDataSource {
  Future<RoundInfo> getInfoRound();
}

class JugabilityLocalDataSourceImpl implements JugabilityLocalDataSource{
  @override
  Future<RoundInfo> getInfoRound() {
    throw UnimplementedError();
  }
}