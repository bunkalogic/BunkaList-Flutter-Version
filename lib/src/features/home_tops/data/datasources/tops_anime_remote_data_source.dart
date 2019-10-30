
import 'package:bunkalist/src/features/home_tops/data/models/anime_model.dart';

abstract class TopsAnimeRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<List<AnimeModel>> getTopsAnimes(int topId);



}