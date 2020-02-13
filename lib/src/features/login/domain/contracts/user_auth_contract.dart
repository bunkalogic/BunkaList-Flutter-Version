
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UserEmailAuthContract{

  Future<Either<Failures, String>> getAuthenticate({
    @required String email,
    @required String password
  });
}