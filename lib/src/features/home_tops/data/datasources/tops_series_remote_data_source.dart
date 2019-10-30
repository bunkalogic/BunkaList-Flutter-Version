
import 'package:bunkalist/src/features/home_tops/data/models/series_model.dart';

abstract class TopsSeriesRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
   Future<List<SeriesModel>> getTopsSeries(int topId);
   



}