

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/serie_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_rs_entity.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';

import 'package:dartz/dartz.dart';

class SeriesRecommendationAndSimilarImpl implements SeriesDetailsRecommendationAndSimilarContracts{
  
  final SeriesRecommendationAndSimilarRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SeriesRecommendationAndSimilarImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });
  
  @override
  Future<Either<Failures, List<SeriesEntityRS>>> getRecommendationsSeries(int id) async {
    if(await networkInfo.isConnected){
      try{

        final remoteSeries = await remoteDataSource.getSeriesRecommedations(id);

        return Right(remoteSeries);


      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failures, List<SeriesEntityRS>>> getSimilarSeries(int id) async {
   if(await networkInfo.isConnected){
      try{

        final remoteSeries = await remoteDataSource.getSeriesSimilar(id);

        return Right(remoteSeries);


      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
    }
  }


}