import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class LoginRepository {
    Future<Either<Failure, String>> loginDevice(Map<String, dynamic> data);
}