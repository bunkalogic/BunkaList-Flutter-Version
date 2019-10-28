import 'dart:core';
import 'package:dartz/dartz.dart';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';




abstract class MovieTopsRepository {

  
   Future<Either<Failures, List<MovieEntity>>> getTopsMovies(int typeTop) async {
    switch (typeTop) {
      
      case 1: return await getTopMoviePopular();  

      case 2: return await getTopMovieRated();     

      case 3: return await getMovieUpcoming();

      case 4: return await  getMovieGenresAction();

      case 5: return await  getMovieGenresAdventure(); 

      case 6: return await getMovieGenresComedy();

      case 7: return await  getMovieGenresWar();

      case 8: return await  getMovieGenresScienceFiction();

      case 9: return await getMovieGenresCrime();

      case 10: return await  getMovieGenresDocumental();

      case 11: return await   getMovieGenresDrama();

      case 12: return await getMovieGenresFamily();

      case 13: return await  getMovieGenresFantasy();

      case 14: return await  getMovieGenresHistory();

      case 15: return await getMovieGenresMistery();

      case 16: return await getMovieGenresMusical();

      case 17: return await  getMovieGenresRomance(); 

      case 18: return await getMovieGenresThriller();

      case 19: return await  getMovieGenresTerror(); 

      case 20: return await getMovieGenresWestern();

      default: return await getTopMoviePopular();
    }
  }


  //? Movie Tops

  Future<Either<Failures, List<MovieEntity>>> getTopMoviePopular();

  Future<Either<Failures, List<MovieEntity>>> getTopMovieRated();

  Future<Either<Failures, List<MovieEntity>>> getMovieUpcoming();

  //? Movie Popular Genres

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresAction();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresAdventure();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresComedy();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresWar();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresScienceFiction();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresCrime();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresDocumental();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresDrama();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresFamily();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresFantasy();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresHistory();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresMistery();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresMusical();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresRomance();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresThriller();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresTerror();

  Future<Either<Failures, List<MovieEntity>>> getMovieGenresWestern();

  

}