

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details.rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_rs_entity.dart';

import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';

import 'package:dartz/dartz.dart';

class AnimeRecommendationAndSimilarImpl implements AnimeDetailsRecommendationAndSimilarContracts{
  
  final AnimeRecommendationAndSimilarRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnimeRecommendationAndSimilarImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });
  
  @override
  Future<Either<Failures, List<AnimeEntityRS>>> getRecommendationsAnime(int id) async {
    if(await networkInfo.isConnected){
      try{

        final remoteAnime = await remoteDataSource.getAnimeRecommedations(id);

        return Right(remoteAnime);


      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failures, List<AnimeEntityRS>>> getSimilarAnime(int id) async {
   if(await networkInfo.isConnected){
      try{

        final remoteAnime = await remoteDataSource.getAnimeSimilar(id);

        return Right(remoteAnime);


      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
    }
  }


}