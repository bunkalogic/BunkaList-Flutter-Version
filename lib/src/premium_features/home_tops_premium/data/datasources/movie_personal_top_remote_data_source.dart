import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';
import 'package:bunkalist/src/core/utils/filter_item_current_in_lists_util.dart';


abstract class MoviesPersonalTopsRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/movie endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<List<MovieModel>> getPersonalTopsMovies(
     int page,
  {
    String sortBy,
    int    year,
    int    voteCountGte,
    String genre,
    String withKeywords,
    String withOriginalLanguage,
  }
  );

}


class MoviesPersonalTopsRemoteDataSourceImpl implements MoviesPersonalTopsRemoteDataSource{
  

  final http.Client client;
  

  MoviesPersonalTopsRemoteDataSourceImpl({@required this.client});

  Preferences prefs = new Preferences();
  
  
  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  bool  _loading = false;
  int totalPage = 1;
  
  @override
  Future<List<MovieModel>> getPersonalTopsMovies(
    int page, 
  {
  String sortBy, 
  int year, 
  int voteCountGte, 
  String genre, 
  String withKeywords, 
  String withOriginalLanguage
  }) async {
    
    if(_loading) return [];
      
    _loading = true;
    
    // esto se encarga de que la pagina no supere la total page
    page = (page <= totalPage) ? page : totalPage;

    // esto se encarga de que la page no sea inferior a 1 
    final _page = (page == 0) ? 1 : page;

    final Map<String, String> query = {
      'api_key'                   : _theMovieDB,
      'language'                  : prefs.getLanguage,
      'page'                      : _page.toString(),
      'year'                      : year.toString(),
      'sort_by'                   : sortBy,
      'vote_count.gte'            : voteCountGte.toString(),
      'with_genres'               : genre,
      'with_original_language'    : withOriginalLanguage
    };


    query.removeWhere((key , value) => value == null);
    query.removeWhere((key , value) => value == 'null');
    query.removeWhere((key , value) => value == '');
    query.removeWhere((key , value) => value == '0');

    final url = Uri.https(
        _url, '3/discover/movie', query);
      

      final resp = await processResponse(url.toString(),);
      // deja de cargar 
      _loading = false;
      // retorna la lista de movies
      return resp;

  }


  Future<List<MovieModel>> processResponse(String url) async {
    print(url);
    final response = await client.get( url, 
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body);
      print('Get PersonalTops Movies total results: ${ decodedData['total_results'] }');

      totalPage = decodedData['total_pages'];

      final listMovies = new Movies.fromJsonList(decodedData['results']);

      if(listMovies.items.isNotEmpty){

        List<MovieModel> itemsFilter = filterMovieCurrentInList(listMovies.items);

        return prefs.hideMoviesInList ? itemsFilter : listMovies.items;

      }else{
        return[];
      }
      
      

    }else{

      throw ServerException();

    }
    
  }




}