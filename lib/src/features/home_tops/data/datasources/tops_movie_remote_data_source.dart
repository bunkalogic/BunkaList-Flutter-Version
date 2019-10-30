
import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';

abstract class TopsMovieRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/movie endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  

  Future<List<MovieModel>> getTopsMovies(int topId);




}