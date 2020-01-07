import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/movie_details_rs_model.dart';
import 'package:http/http.dart' as http ;
import 'package:meta/meta.dart';



abstract class MoviesRecommendationAndSimilarRemoteDataSource{
  /// Calls the http://themoviedb.org/3/movie/{movie_id}/recommendations endpoint.
  /// &
  /// Calls the http://themoviedb.org/3/movie/{movie_id}/similar endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
   
  Future<List<MovieModelRS>> getMoviesRecommedations(int id);

  Future<List<MovieModelRS>> getMoviesSimilar(int id);

}

class MoviesRecommendationAndSimilarRemoteDataSourceImpl implements MoviesRecommendationAndSimilarRemoteDataSource{
  

  final http.Client client;

  MoviesRecommendationAndSimilarRemoteDataSourceImpl({@required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  Preferences prefs = new Preferences();
  
  
  @override
  Future<List<MovieModelRS>> getMoviesRecommedations(int id) async {

    final String url = createUrl('recommendations', id);

    final resp = await processResponse(url);

    return resp;


  }

  @override
  Future<List<MovieModelRS>> getMoviesSimilar(int id) async {
     
    final String url = createUrl('similar', id);

    final resp = await processResponse(url);

    return resp;

  }

  
  String createUrl(String keyword, int id){
    
    final Map<String, String> _query = {
      'api_key'   : _theMovieDB,
      'language'  : prefs.getLanguage.toString()
    };

    final url = Uri.https(_url, '/3/movie/$id/$keyword', _query);

    return url.toString();
  }

  Future<List<MovieModelRS>> processResponse(String url) async {

    print("Url Similar Or Recommmedations : $url");

    final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){

      final decodedData = json.decode(response.body);

      final listMovies = new Movies.fromJsonList(decodedData['results']);

      if(listMovies.items.isNotEmpty){
        
        return listMovies.items;

      }else{

        return [];  

      }

    }else{
       
       throw ServerException();
       
    }

  }

}