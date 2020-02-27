import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_auth_with_google_contract.dart';
import 'package:dartz/dartz.dart';

class GetUserWithGoogleAuth extends UseCase<String, NoParams>{
  
  final UserWithGoogleAuthContract contract;

  GetUserWithGoogleAuth(this.contract);



  @override
  Future<Either<Failures, String>> call(NoParams params) async {

    return await contract.getAuthWithGoogle();

  }

}