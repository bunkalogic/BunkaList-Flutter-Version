import 'dart:core';
import 'package:dartz/dartz.dart';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';




abstract class MovieTopsRepository {

  
   Future<Either<Failures, List<MovieEntity>>> getTopsMovies(int typeTop) async {
    
    switch (typeTop) {
      
      case 1: return await    _getTopMoviePopular();  

      case 2: return await    _getTopMovieRated();     

      case 3: return await    _getMovieUpcoming();

      case 4: return await    _getMovieGenresAction();

      case 5: return await    _getMovieGenresAdventure(); 

      case 6: return await    _getMovieGenresComedy();

      case 7: return await    _getMovieGenresWar();

      case 8: return await    _getMovieGenresScienceFiction();

      case 9: return await    _getMovieGenresCrime();

      case 10: return await   _getMovieGenresDocumental();

      case 11: return await   _getMovieGenresDrama();

      case 12: return await   _getMovieGenresFamily();

      case 13: return await   _getMovieGenresFantasy();

      case 14: return await   _getMovieGenresHistory();

      case 15: return await   _getMovieGenresMistery();

      case 16: return await   _getMovieGenresMusical();

      case 17: return await   _getMovieGenresRomance(); 

      case 18: return await   _getMovieGenresThriller();

      case 19: return await   _getMovieGenresTerror(); 

      case 20: return await   _getMovieGenresWestern();

      default: return await   _getTopMoviePopular();
    }
    
  }


  //? Movie Tops

  Future<Either<Failures, List<MovieEntity>>> _getTopMoviePopular();

 Future<Either<Failures, List<MovieEntity>>> _getTopMovieRated();

 Future<Either<Failures, List<MovieEntity>>> _getMovieUpcoming();

 //? Movie Popular Genres_

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresAction();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresAdventure();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresComedy();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresWar();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresScienceFiction();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresCrime();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresDocumental();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresDrama();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresFamily();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresFantasy();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresHistory();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresMistery();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresMusical();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresRomance();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresThriller();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresTerror();

 Future<Either<Failures, List<MovieEntity>>> _getMovieGenresWestern();

  

}