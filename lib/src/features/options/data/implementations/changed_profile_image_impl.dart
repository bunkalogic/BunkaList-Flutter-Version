import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/features/options/domain/contracts/changed_profile_image_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/options/data/datasources/update_user_info_remote_data_source.dart';

import 'package:dartz/dartz.dart';

class ChangedProfileImageImpl implements ChangeProfileImageContract{
  
  final UpdateUserInfoRemoteDataSource remoteDataSource;


  ChangedProfileImageImpl({@required this.remoteDataSource });

  
  @override
  Future<Either<Failures, void>> changeProfileImage({File newImage}) async {
    
    try{

      final remoteUpdate = await remoteDataSource.updateProfileImage(newImage);

      return Right(remoteUpdate);

    }on ServerException{

      return Left(ServerFailure());

    }

  }

}