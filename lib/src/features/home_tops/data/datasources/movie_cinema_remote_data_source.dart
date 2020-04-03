
import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';

abstract class CinemaMovieRemoteDataSource {

  /// Calls the http://themoviedb.org/3/movie/now_playing endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<List<MovieModel>> getCinemaMovies(int page);

}

class CinemaMovieRemoteDataSourceImpl implements CinemaMovieRemoteDataSource{
  
  final http.Client client;
  

  CinemaMovieRemoteDataSourceImpl({@required this.client});

  Preferences prefs = new Preferences();
  
  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  bool  _loading = false;
  int totalPage = 1;
  
  
  @override
  Future<List<MovieModel>> getCinemaMovies(int page) async {
    
    if(_loading) return [];
      
      _loading = true;
      // carga y agrega un pagina
      // _page++
      page = (page <= totalPage) ? page : totalPage;

      final _page = (page == 0) ? 1 : page;


      final Map<String, String> query = {
          'api_key'         : _theMovieDB,
          'language'        : prefs.getLanguage,
          'page'            : _page.toString(),
          'region'          : prefs.getCountryCode
      };

      final url = Uri.https(
        _url, 
      '3/movie/now_playing',
        query
      );
      
      final resp = await _processResponse(url.toString());
      // deja de cargar 
      _loading = false;
      // retorna la lista de movies
      return resp;

  }

  Future<List<MovieModel>> _processResponse(String url) async {
    
    print(url);

    final response = await client.get( url, 
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body);
      print('Get Cinema Movies total results: ${ decodedData['total_results'] }');

      totalPage = decodedData['total_pages'];

      final listMovies = new Movies.fromJsonList(decodedData['results']);

      if(listMovies.items.isNotEmpty){
        return listMovies.items;
      }else{
        return[];
      }
      
      

    }else{

      throw ServerException();

    }

  }

}