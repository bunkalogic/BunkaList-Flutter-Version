import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/movie_details_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http ;

abstract class MovieDetailsRemoteDataSource {
  /// Calls the http://themoviedb.org/3/movie/{movie_id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<MovieDetailsModel> getMovieDetails(int id);
}


class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource{
  
  final http.Client client;

  MovieDetailsRemoteDataSourceImpl({@required this.client});
  

  Preferences prefs = new Preferences();
  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;

  
  
  
  @override
  Future<MovieDetailsModel> getMovieDetails(int id) async {
    
    final url = Uri.https(_url, '/3/movie/$id', {
      'api_key' : _theMovieDB,
      'language': prefs.getLanguage.toString()
    });

    final resp = await processResponse(url.toString());

    return resp;
  }

  Future<MovieDetailsModel> processResponse(String url) async{
    
    print(url);
    
    final response = await client.get(url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      
      final decodedData = json.decode(response.body);

      final movie = MovieDetailsModel.fromJson(decodedData);

      return movie;

    }else{

      throw ServerException();

    } 

  }
  

}