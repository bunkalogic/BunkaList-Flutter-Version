

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/season_info_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/get_season_info_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class SeasonInfoDetailsImpl implements SeasonInfoDetailsContract{
  
  final SeasonInfoDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SeasonInfoDetailsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });
  
  @override
  Future<Either<Failures, SeasonEntity>> getSeasonInfo(int id, int seasonId) async {
    
    if(await networkInfo.isConnected){
      try{

        final remoteSeasonInfo = await remoteDataSource.getSeasonInfo(id, seasonId);

        return Right(remoteSeasonInfo);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());

    }

  }

}