
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/login/data/datasources/user_auth_token_remote_data_source.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_auth_token_contract.dart';
import 'package:dartz/dartz.dart';

class UserAuthTokenImpl implements UserAuthTokenContracts{
  
  final UserAuthTokenRemoteDataSource remoteDataSource;

  UserAuthTokenImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failures, void>> deleteToken() async {
    try{

      final remoteToken = await remoteDataSource.deleteToken();

      return Right(remoteToken);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

  @override
  Future<Either<Failures, bool>> hasToken() async {
    try{

      final remoteToken = await remoteDataSource.hasToken();

      return Right(remoteToken);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

  @override
  Future<Either<Failures, void>> persistToken(String token) async {
    try{

      final remoteToken = await remoteDataSource.persistToken(token);

      return Right(remoteToken);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

}