
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/options/data/datasources/update_user_info_remote_data_source.dart';
import 'package:bunkalist/src/features/options/domain/contracts/changed_username_contract.dart';
import 'package:dartz/dartz.dart';

class ChangedUsernameImpl implements ChangeUsernameContract{
  
  final UpdateUserInfoRemoteDataSource remoteDataSource;


  ChangedUsernameImpl({@required this.remoteDataSource });

  
  @override
  Future<Either<Failures, void>> changeUsername({String newUsername}) async {
    
    try{

      final remoteUpdate = await remoteDataSource.updateUsername(newUsername);

      return Right(remoteUpdate);

    }on ServerException{

      return Left(ServerFailure());

    }

  }

}