
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/base/domain/contracts/crud_data_user_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class AddUserData extends UseCase<void, AddParams>{
  
  final CrudDataUserContract contract;

  AddUserData(this.contract);
  
  @override
  Future<Either<Failures, void>> call(AddParams params) async {
    
    return await contract.addUserDataInFirebase(params.userEntity);

  }

}


class AddParams extends Equatable{
  
  final UserEntity userEntity;

  AddParams({@required this.userEntity}) : super([userEntity]);
  
}