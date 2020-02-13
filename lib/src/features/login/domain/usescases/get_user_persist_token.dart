import 'package:bunkalist/src/features/login/domain/contracts/user_auth_token_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUserPersistToken extends UseCase< void, Params>{
  
  final UserAuthTokenContracts contract;

  GetUserPersistToken(this.contract);



  @override
  Future<Either<Failures, void>> call(params) async {
    
    return await contract.persistToken(params.token);

  }

}

class Params extends Equatable{
  
  final String token;

  Params({ @required this.token }) : super([token]);
}