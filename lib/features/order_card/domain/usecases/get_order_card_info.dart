import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/order_card_info.dart';
import '../repositories/order_card_repository.dart';

class GetOrderCardInfo implements UseCase<OrderCardInfo, NoParams> {
  final OrderCardRepository repository;

  GetOrderCardInfo({required this.repository});

  @override
  Future<Either<Failure, OrderCardInfo>> call(NoParams params) async {
    return await repository.getOrderCardInfo();
  }
}