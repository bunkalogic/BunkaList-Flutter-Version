
import 'package:bunkalist/src/features/ouevre_details/data/models/anime_details_model.dart';

abstract class AnimeDetailsRemoteDataSource {
  /// Calls the http://themoviedb.org/3/tv/{tv_id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<AnimeDetailsModel> getAnimeDetails(int id);
}