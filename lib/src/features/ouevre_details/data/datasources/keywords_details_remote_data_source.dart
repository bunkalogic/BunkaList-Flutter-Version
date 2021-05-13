import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'package:meta/meta.dart';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/keywords_model.dart';

abstract class KeywordsRemoteDataSource{
  /// Calls the http://themoviedb.org/3/movie/{movie_id}/keywords endpoint.
  /// 
  /// Calls the http://themoviedb.org/3/tv/{tv_id}/keywords endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<KeywordsModel> getKeywords(int id, String type);
  
}


class KeywordsRemoteDataSourceImpl extends KeywordsRemoteDataSource{
  
  final http.Client client;

  KeywordsRemoteDataSourceImpl({@required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  Preferences prefs = new Preferences();
  
  
  @override
  Future<KeywordsModel> getKeywords(int id, String type)  async {
    
    String urlFinal;

    final Map<String, String> _query = {
      'api_key' : _theMovieDB,
    };

      if(type == 'movie'){

      final url = Uri.https(_url, '/3/movie/$id/keywords', _query);

      urlFinal = url.toString();

    }else if(type == 'tv' || type == 'anime'){

      final url = Uri.https(_url, '/3/tv/$id/keywords', _query);

      urlFinal = url.toString();
    } 


    final response = await processResponse(urlFinal);

    return response;


  }


  Future<KeywordsModel> processResponse(String url) async{

    print("Url Keywords : $url");

    final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){

      final decodedData = json.decode(response.body);

      final credits = KeywordsModel.fromJson(decodedData);

      return credits;

    }else{

      throw ServerException();

    }

  }

}