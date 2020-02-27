
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/features/login/data/datasources/user_auth_with_google_remote_data_source.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_auth_with_google_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class UserWithGoogleAuthImpl implements UserWithGoogleAuthContract{
  
  final UserWithGoogleAuthRemoteDataSource remoteDataSource;

  UserWithGoogleAuthImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failures, String>> getAuthWithGoogle() async {
   try{

    final googleAuth = await remoteDataSource.getAuthWithGoogle();

    return Right(googleAuth);

   }on ServerException{

    return Left(ServerFailure());     

   }
  }

}