import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/supplier_item.dart';
import '../repositories/suppliers_repository.dart';

class GetSupplierItems extends UseCase<List<SupplierItem>,NoParams> {
  final SuppliersRepository repository;

  GetSupplierItems(this.repository);

  @override
  Future<Either<Failure, List<SupplierItem>>> call(NoParams params) async {
    return await repository.getSupplierItems();
  }
}