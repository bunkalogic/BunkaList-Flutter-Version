

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/base/domain/contracts/crud_data_user_contract.dart';
import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

class GetUserData extends UseCase<void, NoParams>{
  
  final CrudDataUserContract contract;

  GetUserData(this.contract);
  
  @override
  Future<Either<Failures, Stream<UserEntity>>> call(NoParams params) async {
    
    return contract.getUserDataInFirebase();

  }

}