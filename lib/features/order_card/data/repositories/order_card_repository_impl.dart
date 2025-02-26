import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/order_card_info.dart';
import '../../domain/repositories/order_card_repository.dart';
import '../datasources/order_card_local_datasource.dart';

class OrderCardRepositoryImpl implements OrderCardRepository {
  final OrderCardLocalDatasource orderCardLocalDatasource;
  final NetworkInfo networkInfo;

  OrderCardRepositoryImpl({
    required this.orderCardLocalDatasource,
    required this.networkInfo  
  });
  
  @override
  Future<Either<Failure, OrderCardInfo>> getOrderCardInfo() async {
    if (await networkInfo.isConnected) {
      try {
        final localOrderCardInfo = await orderCardLocalDatasource.getOrderCardInfo();
        return Right(localOrderCardInfo);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

}