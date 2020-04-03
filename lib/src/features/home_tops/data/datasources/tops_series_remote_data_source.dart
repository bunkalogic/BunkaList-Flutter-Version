
import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:bunkalist/src/core/constans/constans_genres_id.dart';
import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/home_tops/data/models/series_model.dart';
import 'package:bunkalist/internal/keys.dart';

abstract class TopsSeriesRemoteDataSource{

  /// Calls the http://theSeriedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
   Future<List<SeriesModel>> getTopsSeries(int topId, int page);
}

class TopsSeriesRemoteDataSourceImpl implements TopsSeriesRemoteDataSource  {
  
  final http.Client client;
  

  TopsSeriesRemoteDataSourceImpl({@required this.client});

  /// Calls the http://theSeriedb.org/3/discover/Serie endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Preferences prefs = new Preferences();
  
  
  final _url      = 'api.themoviedb.org';
  final _theSerieDB = theMovieDbAPiKey;
  int totalPage = 1;
  bool  _loading = false;
  

  Future<List<SeriesModel>>  getListSerieFromApi(int page, {String sortBy, int voteCount, int voteAverage, String genres, String network, String airDateLte, String airDateGte}) async {
      if(_loading) return [];
      
      _loading = true;
      // carga y agrega un pagina
      //_page++;
      page = (page <= totalPage) ? page : totalPage;

      final _page = (page == 0) ? 1 : page;

      final Map<String, String> query = {
          'api_key'         : _theSerieDB,
          'language'        : prefs.getLanguage,
          'page'            : _page.toString(),
          'sort_by'         : sortBy,
          'air_date.gte'    : airDateGte,
          'air_date.lte'    : airDateLte,
          'vote_count.gte'  : voteCount.toString(),
          'vote_average.gte': voteAverage.toString(),
          'with_genres'     : genres,
          'with_networks'   : network,
          'without_genres'  : '16'
      };

      query.removeWhere((key , value) => value == null);
      query.removeWhere((key , value) => value == 'null');


      final url = Uri.https(
        _url, '3/discover/tv', query);

      

      final resp = await processResponse(url.toString());
      // deja de cargar 
      _loading = false;
      // retorna la lista de Series
      return resp;

      
  }

  Future<List<SeriesModel>> processResponse(String url) async {
    print(url);
    final response = await client.get( url, 
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body);
      print('Get Tops Series total results: ${ decodedData['total_results'] }');

      totalPage = decodedData['total_pages'];

      final listSeries = new Series.fromJsonList(decodedData['results']);

      if(listSeries.items.isNotEmpty){
        return listSeries.items;
      }else{
        return [];
      }

      
      

    }else{

      throw ServerException();

    }
    
  }
  
  
  
  @override
  Future<List<SeriesModel>> getTopsSeries(int topId, int page) {
    switch (topId) {

      case Constants.topsSeriesPopularId        : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc);

      case Constants.topsSeriesRatedId          : return getListSerieFromApi(page, sortBy: ConstSortBy.voteAverageDesc, voteCount: 600);

      case Constants.topsSeriesUpcommingId      : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, airDateGte: '2020-04-31', airDateLte: '2020-06-31' );

      case Constants.topsSeriesActAndAdvId      : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.actionAndAveture.toString());

      case Constants.topsSeriesComedyId         : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.comedy.toString());

      case Constants.topsSeriesDocumentalId     : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.documentary.toString());

      case Constants.topsSeriesDramaId          : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.drama.toString());

      case Constants.topsSeriesFamilyId         : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.family.toString());

      case Constants.topsSeriesFantasyAndSciFiId: return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.sciFiAndFantasy.toString());

      case Constants.topsSeriesSoapId           : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.soap.toString());

      case Constants.topsSeriesWarAndPoliticsId : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.warAndPolitics.toString());

      case Constants.topsSeriesMisteryId        : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.mistery.toString());

      case Constants.topsSeriesWesternId        : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.western.toString());     
      
      case Constants.topsSeriesNetflixId        : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, network: '213' );

      case Constants.topsSeriesHBOId            : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, network: '49' );

      case Constants.topsSeriesAmazonPrimeId    : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, network: '1024' );

      case Constants.topsSeriesBBCOneId         : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, network: '4' );

      case Constants.topsSeriesAMCId            : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, network: '174' );

      case Constants.topsSeriesMonthId          : return getListSerieFromApi(page, sortBy: ConstSortBy.popularityDesc, airDateGte: '2020-04-01', airDateLte: '2020-05-01'  );


      default: return null;
    }
  }



}