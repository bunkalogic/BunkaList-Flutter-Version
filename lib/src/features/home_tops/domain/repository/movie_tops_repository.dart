import 'dart:core';
import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:dartz/dartz.dart';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';




abstract class MovieTopsRepository {

  
   Future<Either<Failures, List<MovieEntity>>> getTopsMovies(int typeTop, int page,) async {
    
    switch (typeTop) {

      case Constants.topsMoviesPopularId        :  return await   _getTopMoviePopular();  

      case Constants.topsMoviesRatedId          : return await    _getTopMovieRated();     

      case Constants.topsMoviesUpcommingId      : return await    _getMovieUpcoming();

      case Constants.topsMoviesActionId         : return await    _getMovieGenresAction();

      case Constants.topsMoviesAdventureId      : return await    _getMovieGenresAdventure(); 

      case Constants.topsMoviesComedyId         : return await    _getMovieGenresComedy();

      case Constants.topsMoviesWarId            : return await    _getMovieGenresWar();

      case Constants.topsMoviesScienceFictionId : return await    _getMovieGenresScienceFiction();

      case Constants.topsMoviesCrimeId          : return await    _getMovieGenresCrime();

      case Constants.topsMoviesDocumentalId     : return await   _getMovieGenresDocumental();

      case Constants.topsMoviesDramaId          : return await   _getMovieGenresDrama();

      case Constants.topsMoviesFamilyId         : return await   _getMovieGenresFamily();

      case Constants.topsMoviesFantasyId        : return await   _getMovieGenresFantasy();

      case Constants.topsMoviesHistoryId        : return await   _getMovieGenresHistory();

      case Constants.topsMoviesMisteryId        : return await   _getMovieGenresMistery();

      case Constants.topsMoviesMusicalId        : return await   _getMovieGenresMusical();

      case Constants.topsMoviesRomanceId        : return await   _getMovieGenresRomance(); 

      case Constants.topsMoviesThillerId        : return await   _getMovieGenresThriller();

      case Constants.topsMoviesTerrorId         : return await   _getMovieGenresTerror(); 

      case Constants.topsMoviesWesternId        : return await   _getMovieGenresWestern();

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