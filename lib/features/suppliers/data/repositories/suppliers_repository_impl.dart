import 'package:dartz/dartz.dart';
import 'package:master_case/core/error/failures.dart';
import 'package:master_case/core/network/network_info.dart';
import 'package:master_case/features/suppliers/data/datasources/supplier_remote_datasource.dart';
import 'package:master_case/features/suppliers/domain/entities/supplier_item.dart';
import 'package:master_case/features/suppliers/domain/repositories/suppliers_repository.dart';

class SuppliersRepositoryImpl implements SuppliersRepository {

  final SupplierRemoteDatasource supplierRemoteDatasource;
  final NetworkInfo networkInfo;

  SuppliersRepositoryImpl({
    required this.supplierRemoteDatasource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, List<SupplierItem>>> getSupplierItems() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSupplierItems = await supplierRemoteDatasource.getSupplierItems();
        return Right(remoteSupplierItems);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

}