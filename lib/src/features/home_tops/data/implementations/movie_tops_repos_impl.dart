

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
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresAction() {
    // TODO: implement getMovieGenresAction
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresAdventure() {
    // TODO: implement getMovieGenresAdventure
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresComedy() {
    // TODO: implement getMovieGenresComedy
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresCrime() {
    // TODO: implement getMovieGenresCrime
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresDocumental() {
    // TODO: implement getMovieGenresDocumental
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresDrama() {
    // TODO: implement getMovieGenresDrama
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresFamily() {
    // TODO: implement getMovieGenresFamily
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresFantasy() {
    // TODO: implement getMovieGenresFantasy
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresHistory() {
    // TODO: implement getMovieGenresHistory
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresMistery() {
    // TODO: implement getMovieGenresMistery
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresMusical() {
    // TODO: implement getMovieGenresMusical
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresRomance() {
    // TODO: implement getMovieGenresRomance
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresScienceFiction() {
    // TODO: implement getMovieGenresScienceFiction
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresTerror() {
    // TODO: implement getMovieGenresTerror
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresThriller() {
    // TODO: implement getMovieGenresThriller
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresWar() {
    // TODO: implement getMovieGenresWar
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieGenresWestern() {
    // TODO: implement getMovieGenresWestern
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getMovieUpcoming() {
    // TODO: implement getMovieUpcoming
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getTopMoviePopular() {
    // TODO: implement getTopMoviePopular
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getTopMovieRated() {
    // TODO: implement getTopMovieRated
    return null;
  }

  @override
  Future<Either<Failures, List<MovieEntity>>> getTopsMovies(int typeTop) {
    return null;
  }
  
}