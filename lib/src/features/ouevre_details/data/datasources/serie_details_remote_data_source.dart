
import 'package:bunkalist/src/features/ouevre_details/data/models/serie_details_model.dart';

abstract class SerieDetailsRemoteDataSource {
  /// Calls the http://themoviedb.org/3/tv/{tv_id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<SerieDetailsModel> getSerieDetails(int id);
}