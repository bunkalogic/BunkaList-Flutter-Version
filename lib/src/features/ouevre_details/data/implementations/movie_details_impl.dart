import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class MovieDetailsImpl implements MovieDetailsContract {
  final MovieDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MovieDetailsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  
  @override
  Future<Either<Failures, MovieDetailsEntity>> getDetailsMovie(int id) async {
    networkInfo.isConnected;
    try {
      
      final remoteMovieDetails = await remoteDataSource.getMovieDetails(id);
      return Right(remoteMovieDetails);

    } on ServerException{
      
      return Left(ServerFailure());

    }
  }

}