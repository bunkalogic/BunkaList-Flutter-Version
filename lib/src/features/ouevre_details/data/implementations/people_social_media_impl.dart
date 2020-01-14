import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_social_media_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_social_media_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_social_media_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class PeopleSocialMediaImpl extends PeopleSocialMediaContract{
  
  final PeopleSocialMediaRemoteDataSource remoteDataSource;
    final NetworkInfo networkInfo;

    PeopleSocialMediaImpl({
      @required this.remoteDataSource,
      @required this.networkInfo
    });
  
  
  @override
  Future<Either<Failures, PeopleSocialMediaEntity>> getPeopleSocialMedia(int id) async {
    
    if(await networkInfo.isConnected){
      try{

        final remoteSocialMedia = await remoteDataSource.getPeopleSocialMedia(id);

        return Right(remoteSocialMedia);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());

    }

  }

}