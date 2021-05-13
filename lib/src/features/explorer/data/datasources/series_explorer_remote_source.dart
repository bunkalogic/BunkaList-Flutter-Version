
import 'dart:convert';
import 'dart:io';
import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:bunkalist/src/features/home_tops/data/models/series_model.dart';
import 'package:bunkalist/src/core/utils/filter_item_current_in_lists_util.dart';


abstract class SeriesExplorerRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<List<SeriesModel>> getExplorerSeries(
     int page,
  {
    String sortBy,
    int    year,
    int    voteCountGte,
    String genre,
    String withKeywords,
    String withNetwork,
    String withCompanies,
    String withWatchProvider
  }
  );

}

class SeriesExplorerRemoteDataSourceImpl implements SeriesExplorerRemoteDataSource{
  
  final http.Client client;
  

  SeriesExplorerRemoteDataSourceImpl({@required this.client});

  /// Calls the http://theSeriedb.org/3/discover/Serie endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Preferences prefs = new Preferences();
  
  
  final _url      = 'api.themoviedb.org';
  final _theSerieDB = theMovieDbAPiKey;
  int totalPage = 1;
  bool  _loading = false;
  
  
  
  @override
  Future<List<SeriesModel>> getExplorerSeries(
    int page, {
      String sortBy, 
      int year, 
      int voteCountGte, 
      String genre, 
      String withKeywords, 
      String withNetwork,
      String withCompanies,
      String withWatchProvider
    }) async {
    if(_loading) return [];
      
      _loading = true;
      
      // esto se encarga de que la pagina no supere la total page
      page = (page <= totalPage) ? page : totalPage;

      // esto se encarga de que la page no sea inferior a 1 
      final _page = (page == 0) ? 1 : page;


      final Map<String, String> query = {
          'api_key'               : _theSerieDB,
          'language'              : prefs.getLanguage,
          'page'                  : _page.toString(),
          'sort_by'               : sortBy,
          'first_air_date_year'   : year.toString(),
          'vote_count.gte'        : voteCountGte.toString(),
          'with_genres'           : genre,
          'with_networks'         : withNetwork,
          'with_keywords'         : withKeywords,
          'without_genres'        : '16',
          'with_companies'        : withCompanies,
          'with_watch_providers'  : withWatchProvider,
          'include_null_first_air_dates' : 'false'
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
      print('Get Explorer Series total results: ${ decodedData['total_results'] }');

      totalPage = decodedData['total_pages'];

      final listSeries = new Series.fromJsonList(decodedData['results']);

      if(listSeries.items.isNotEmpty){

        List<SeriesModel> itemsFilter = filterSerieCurrentInList(listSeries.items);


        return prefs.hideSeriesInList ? itemsFilter : listSeries.items;

      }else{
        return [];
      }

      
      

    }else{

      throw ServerException();

    }
    
  }  
}