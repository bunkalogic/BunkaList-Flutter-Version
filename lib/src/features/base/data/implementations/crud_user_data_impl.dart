import 'package:bunkalist/src/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/base/data/datasources/crud_user_remote_data_source.dart';
import 'package:bunkalist/src/features/base/domain/contracts/crud_data_user_contract.dart';
import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

class CrudUserDataImpl implements CrudDataUserContract{
  
  
  final CrudUserRemoteDataSource remoteDataSource;

  CrudUserDataImpl({@required this.remoteDataSource});
  
  
  @override
  Future<Either<Failures, void>> addUserDataInFirebase(UserEntity userEntity) async {
    try{

      final remote = await remoteDataSource.addUserDataInFirebase(userEntity.toModel());

      return Right(remote);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

  @override
  Either<Failures, Stream<UserEntity>> getUserDataInFirebase() {
    try{

      final remote = remoteDataSource.getOfFirebase();

      return Right(remote);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

  @override
  Future<Either<Failures, void>> updateUserDataInFirebase(UserEntity userEntity) async {
    try{

      final remote = await remoteDataSource.updateUserDataInFirebase(userEntity.toModel());

      return Right(remote);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

}