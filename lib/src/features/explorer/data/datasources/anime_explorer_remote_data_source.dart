import 'dart:convert';
import 'dart:io';
import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:bunkalist/src/core/utils/filter_item_current_in_lists_util.dart';
import 'package:bunkalist/src/features/home_tops/data/models/anime_model.dart';

abstract class AnimesExplorerRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<List<AnimeModel>> getExplorerAnimes(
     int page,
  {
    String sortBy,
    int    year,
    int    voteCountGte,
    String genre,
    String withKeywords,
    String withNetwork,
  }
  );

}

class AnimesExplorerRemoteDataSourceImpl implements AnimesExplorerRemoteDataSource{

   final http.Client client;
  

  AnimesExplorerRemoteDataSourceImpl({@required this.client});

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Preferences prefs = new Preferences();
  
  
  final _url      = 'api.themoviedb.org';
  final _theAnimeDB = theMovieDbAPiKey;
  bool  _loading = false;
  int totalPage = 1;




  @override
  Future<List<AnimeModel>> getExplorerAnimes(
    int page, {
      String sortBy,
      int year, 
      int voteCountGte,  
      String genre, 
      String withKeywords, 
      String withNetwork
    }) async {
    
      if(_loading) return [];
      
      _loading = true;
      
     // esto se encarga de que la pagina no supere la total page
      page = (page <= totalPage) ? page : totalPage;

      // esto se encarga de que la page no sea inferior a 1 
      final _page = (page == 0) ? 1 : page;

    final Map<String, String> query = {
         'api_key'               : _theAnimeDB,
          'language'              : prefs.getLanguage,
          'page'                  : _page.toString(),
          'sort_by'               : sortBy,
          'first_air_date_year'   : year.toString(),
          'vote_count.gte'        : voteCountGte.toString(),
          'with_genres'           : '16,$genre',
          'with_original_language': 'ja',
          'with_keywords'         : withKeywords
          
      };

      query.removeWhere((key , value) => value == null);
      query.removeWhere((key , value) => value == 'null');


      final url = Uri.https(
        _url, '3/discover/tv', query);

      
      
      final resp = await processResponse(url.toString());
      // deja de cargar 
      _loading = false;
      // retorna la lista de Anime
      return resp;
  }


  
  Future<List<AnimeModel>> processResponse(String url) async {
    print(url);
    final response = await client.get( url, 
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body);
      print('Get Explorer Anime total results: ${ decodedData['total_results'] }');

      totalPage = decodedData['total_pages'];

      final listAnime = new Animes.fromJsonList(decodedData['results']);

      if(listAnime.items.isNotEmpty){

        List<AnimeModel> itemsFilter = filterAnimeCurrentInList(listAnime.items);

        return prefs.hideAnimeInList ? itemsFilter : listAnime.items;

      }else{
        return [];
      }
      
      

    }else{

      throw ServerException();

    }
    
  }

}