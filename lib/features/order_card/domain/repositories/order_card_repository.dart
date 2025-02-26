import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/order_card_info.dart';

abstract class OrderCardRepository {
  Future<Either<Failure, OrderCardInfo>> getOrderCardInfo();
}