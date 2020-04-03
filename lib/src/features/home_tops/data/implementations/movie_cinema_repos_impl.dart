
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/movie_cinema_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/movie_cinema_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';

class MovieCinemaRepositoryImpl implements MoviesCinemaRepository{

  final CinemaMovieRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MovieCinemaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });


  @override
  Future<Either<Failures, List<MovieEntity>>> getCinemaMovies(int page) async {
    networkInfo.isConnected;
    try {

      final remoteMovies = await remoteDataSource.getCinemaMovies( page);
      return Right(remoteMovies);

    } on ServerException {

      return Left(ServerFailure());

    }
  }
  
}