import 'package:bunkalist/src/features/ouevre_details/data/models/movie_details_model.dart';

abstract class MovieDetailsRemoteDataSource {
  /// Calls the http://themoviedb.org/3/movie/{movie_id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<MovieDetailsModel> getMovieDetails(int id);
}