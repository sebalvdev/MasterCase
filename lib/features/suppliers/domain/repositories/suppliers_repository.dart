import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/supplier_item.dart';

abstract class SuppliersRepository {
  Future<Either<Failure, List<SupplierItem>>> getSupplierItems ();
}