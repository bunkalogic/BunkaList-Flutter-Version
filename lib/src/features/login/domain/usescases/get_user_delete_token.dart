import 'package:bunkalist/src/features/login/domain/contracts/user_auth_token_contract.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:dartz/dartz.dart';

class GetUserAuthToken extends UseCase< void, NoParams>{
  
  final UserAuthTokenContracts contract;

  GetUserAuthToken(this.contract);



  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    
    return await contract.deleteToken();

  }

}

