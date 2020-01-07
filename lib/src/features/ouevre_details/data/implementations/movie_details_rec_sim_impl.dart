

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_rec_sim_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_rs_entity.dart';
import 'package:dartz/dartz.dart';

class MoviesRecommendationAndSimilarImpl implements MoviesDetailsRecommendationAndSimilarContracts{
  
  final MoviesRecommendationAndSimilarRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MoviesRecommendationAndSimilarImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });
  
  @override
  Future<Either<Failures, List<MovieEntityRS>>> getRecommendationsMovie(int id) async {
    if(await networkInfo.isConnected){
      try{

        final remoteMovies = await remoteDataSource.getMoviesRecommedations(id);

        return Right(remoteMovies);


      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failures, List<MovieEntityRS>>> getSimilarMovie(int id) async {
   if(await networkInfo.isConnected){
      try{

        final remoteMovies = await remoteDataSource.getMoviesSimilar(id);

        return Right(remoteMovies);


      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
    }
  }


}