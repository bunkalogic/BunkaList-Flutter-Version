
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/data/datasources/movie_personal_top_remote_data_source.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/movie_personal_top_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';

class MoviesPersonalTopsImpl extends MoviePersonalTopsContract{

  final MoviesPersonalTopsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MoviesPersonalTopsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });



  @override
  Future<Either<Failures, List<MovieEntity>>> getMoviesPersonalTops(int page, 
  {
  String sortBy, 
  int year, 
  int voteCountGte, 
  String genre, 
  String withKeywords, 
  String withOriginalLanguage
  }
  ) async {
    
    if(await networkInfo.isConnected){

      try{

        final remotePersonalTopsMovies = await remoteDataSource.getPersonalTopsMovies(
          page,
          genre: genre,
          sortBy: sortBy,
          voteCountGte: voteCountGte,
          withKeywords: withKeywords,
          withOriginalLanguage: withOriginalLanguage,
          year: year
        
        );

        return Right(remotePersonalTopsMovies);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());
    
    }


  }

}