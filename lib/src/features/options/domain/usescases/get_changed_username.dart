
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/options/domain/contracts/changed_username_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:equatable/equatable.dart';

class GetChangedUsername extends UseCase<void, ParamsUP>{
  
  final  ChangeUsernameContract contract;

  GetChangedUsername(this.contract);


  @override
  Future<Either<Failures, void>> call(ParamsUP paramsUP) async {
    
    return await contract.changeUsername(newUsername: paramsUP.newUsername);

  }

}

class ParamsUP extends Equatable{
  
  final String newUsername;

  ParamsUP({ @required this.newUsername}) : super([newUsername]);
}