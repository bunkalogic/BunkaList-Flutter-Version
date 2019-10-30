

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_movie_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/movie_tops_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class MovieTopsRepositoryImpl implements MovieTopsRepository{

  final TopsMovieRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MovieTopsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failures, List<MovieEntity>>> getTopsMovies(int typeTop) async {
    networkInfo.isConnected;
    try {

      final remoteMovies = await remoteDataSource.getTopsMovies(typeTop);
      return Right(remoteMovies);

    } on ServerException {

      return Left(ServerFailure());

    }
  }
  
}