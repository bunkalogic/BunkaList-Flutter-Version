
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UserAuthTokenContracts{

  Future<Either<Failures, bool>> hasToken();

  Future<Either<Failures, void>> deleteToken();

  Future<Either<Failures, void>> persistToken(String token);

}