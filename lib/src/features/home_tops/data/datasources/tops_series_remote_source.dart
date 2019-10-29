
import 'package:bunkalist/src/features/home_tops/data/models/series_model.dart';

abstract class TopsSeriesRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
   Future<List<SeriesModel>> getTopSeriesPopular();
   Future<List<SeriesModel>> getTopSeriesRated();
   Future<List<SeriesModel>> getSeriesUpcoming();
   Future<List<SeriesModel>> getSeriesGenresActionAndAdventure();
   Future<List<SeriesModel>> getSeriesGenresComedy();
   Future<List<SeriesModel>> getSeriesGenresCrimen();
   Future<List<SeriesModel>> getSeriesGenresDocumental();
   Future<List<SeriesModel>> getSeriesGenresDrama();
   Future<List<SeriesModel>> getSeriesGenresFamily();
   Future<List<SeriesModel>> getSeriesGenresMistery();
   Future<List<SeriesModel>> getSeriesGenresFantasyAndSciFi();
   Future<List<SeriesModel>> getSeriesGenresSoap();
   Future<List<SeriesModel>> getSeriesGenresWarAndPolitics();
   Future<List<SeriesModel>> getSeriesGenresWestern();
   Future<List<SeriesModel>> getSeriesCompanyNetflix();
   Future<List<SeriesModel>> getSeriesCompanyHBO();
   Future<List<SeriesModel>> getSeriesCompanyAmazonPrime();
   Future<List<SeriesModel>> getSeriesCompanyBBCOne();
   Future<List<SeriesModel>> getSeriesCompanyAMC();



}