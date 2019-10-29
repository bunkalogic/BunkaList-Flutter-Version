
import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';

abstract class TopsMovieRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/movie endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  

  Future<List<MovieModel>> getTopMoviePopular();
  Future<List<MovieModel>> getTopMovieRated();
  Future<List<MovieModel>> getMovieUpcoming();
  Future<List<MovieModel>> getMovieGenresAction();
  Future<List<MovieModel>> getMovieGenresAdventure();
  Future<List<MovieModel>> getMovieGenresComedy();
  Future<List<MovieModel>> getMovieGenresWar();
  Future<List<MovieModel>> getMovieGenresScienceFiction();
  Future<List<MovieModel>> getMovieGenresCrime();
  Future<List<MovieModel>> getMovieGenresDocumental();
  Future<List<MovieModel>> getMovieGenresDrama();
  Future<List<MovieModel>> getMovieGenresFamily();
  Future<List<MovieModel>> getMovieGenresFantasy();
  Future<List<MovieModel>> getMovieGenresHistory();
  Future<List<MovieModel>> getMovieGenresMistery();
  Future<List<MovieModel>> getMovieGenresMusical();
  Future<List<MovieModel>> getMovieGenresRomance();
  Future<List<MovieModel>> getMovieGenresThriller();
  Future<List<MovieModel>> getMovieGenresTerror();
  Future<List<MovieModel>> getMovieGenresWestern();





}