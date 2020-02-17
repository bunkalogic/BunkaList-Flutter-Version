
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UserRegisterContract{

  Future<Either<Failures, void>> getRegister({
    @required String email,
    @required String password
  });
}