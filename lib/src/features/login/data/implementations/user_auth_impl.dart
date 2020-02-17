
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/login/data/datasources/user_auth_remote_data_source.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_auth_contract.dart';
import 'package:dartz/dartz.dart';

class UserEmailAuthImpl implements UserEmailAuthContract{
  
  final UserAuthRemoteDataSource remoteDataSource;

  UserEmailAuthImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failures, String>> getAuthenticate({String email, String password}) async {

      try{
        
        final remoteAuth = await remoteDataSource.getAuthenticate(email: email, password: password);

        return Right(remoteAuth);

      }on ServerException{

        return Left(ServerFailure());

      }
  }

}