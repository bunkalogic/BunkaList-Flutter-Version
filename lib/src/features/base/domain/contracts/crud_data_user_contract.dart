

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CrudDataUserContract{


  Future<Either<Failures, void>> addUserDataInFirebase(UserEntity userEntity);

  Either<Failures, Stream<UserEntity>> getUserDataInFirebase();

  Future<Either<Failures, void>> updateUserDataInFirebase(UserEntity userEntity);

}