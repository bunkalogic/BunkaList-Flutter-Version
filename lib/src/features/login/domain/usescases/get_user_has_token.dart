import 'package:bunkalist/src/features/login/domain/contracts/user_auth_token_contract.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:dartz/dartz.dart';


class GetUserHasToken extends UseCase<bool, NoParams>{
  
  final UserAuthTokenContracts contract;

  GetUserHasToken(this.contract);



  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    
    return await contract.hasToken();

  }

}
