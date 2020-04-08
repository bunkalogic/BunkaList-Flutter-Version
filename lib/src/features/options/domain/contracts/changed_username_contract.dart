
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ChangeUsernameContract{

  Future<Either<Failures, void>> changeUsername({@required String newUsername });
  
}