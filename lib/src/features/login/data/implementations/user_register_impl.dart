
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/features/login/data/datasources/user_register_remote_data_source.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_register_auth_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class UserRegisterImpl implements UserRegisterContract{
  
  final UserRegisterRemoteDataSource remoteDataSource;

  UserRegisterImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failures, void>> getRegister({String email, String password}) async {

      try{
        
        final remoteAuth = await remoteDataSource.getRegister(email: email, password: password);

        return Right(remoteAuth);

      }on ServerException{

        return Left(ServerFailure());

      }
  }

}