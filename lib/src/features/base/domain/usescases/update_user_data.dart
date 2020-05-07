import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/base/domain/contracts/crud_data_user_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class UpdateUserData extends UseCase<void, UpdateParams>{
  
  final CrudDataUserContract contract;

  UpdateUserData(this.contract);
  
  @override
  Future<Either<Failures, void>> call(UpdateParams params) async {
    
    return await contract.updateUserDataInFirebase(params.userEntity);

  }

}


class UpdateParams extends Equatable{
  
  final UserEntity userEntity;

  UpdateParams({@required this.userEntity}) : super([userEntity]);
  
}