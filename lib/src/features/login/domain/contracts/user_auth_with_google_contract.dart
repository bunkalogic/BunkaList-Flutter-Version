
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UserWithGoogleAuthContract{

  Future<Either<Failures, String>> getAuthWithGoogle();
}