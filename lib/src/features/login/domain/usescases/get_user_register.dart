import 'package:bunkalist/src/features/login/domain/contracts/user_register_auth_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUserRegister extends UseCase<void, Params>{
  
  final UserRegisterContract contract;

  GetUserRegister(this.contract);



  @override
  Future<Either<Failures, void>> call(params) async {
    
    return await contract.getRegister(email: params.email, password: params.password);

  }

}

class Params extends Equatable{
  
  final String email;
  final String password;

  Params({ @required this.email, @required this.password }) : super([email, password]);
}