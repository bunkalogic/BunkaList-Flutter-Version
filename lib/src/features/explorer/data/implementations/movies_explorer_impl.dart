
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/explorer/data/datasources/movies_explorer_remote_data_source.dart';
import 'package:bunkalist/src/features/explorer/domain/contracts/movie_explorer_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';

class MoviesExplorerImpl extends MovieExplorerContract{

  final MoviesExplorerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MoviesExplorerImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });



  @override
  Future<Either<Failures, List<MovieEntity>>> getMoviesExplorer(int page, 
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

        final remoteExplorerMovies = await remoteDataSource.getExplorerMovies(
          page,
          genre: genre,
          sortBy: sortBy,
          voteCountGte: voteCountGte,
          withKeywords: withKeywords,
          withOriginalLanguage: withOriginalLanguage,
          year: year
        
        );

        return Right(remoteExplorerMovies);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());
    
    }


  }

}