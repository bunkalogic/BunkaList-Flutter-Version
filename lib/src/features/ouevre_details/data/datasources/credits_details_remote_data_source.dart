import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'package:meta/meta.dart';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/credits_details_model.dart';

abstract class CreditsDetailsRemoteDataSource{
  /// Calls the http://themoviedb.org/3/movie/{movie_id}/credits endpoint.
  /// 
  /// Calls the http://themoviedb.org/3/tv/{tv_id}/credits endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<CreditsDetailsModel> getCredits(int id, String type);
  
}

class CreditsDetailsRemoteDataSourceImpl implements CreditsDetailsRemoteDataSource{
  
  final http.Client client;

  CreditsDetailsRemoteDataSourceImpl({@required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  Preferences prefs = new Preferences();
  
  @override
  Future<CreditsDetailsModel> getCredits(int id, String type) async {
    
    String urlFinal;

    final Map<String, String> _query = {
      'api_key' : _theMovieDB,
      'language': prefs.getLanguage.toString()
    };

      if(type == 'movie'){

      final url = Uri.https(_url, '/3/movie/$id/credits', _query);

      urlFinal = url.toString();

    }else if(type == 'tv' || type == 'anime'){

      final url = Uri.https(_url, '/3/tv/$id/credits', _query);

      urlFinal = url.toString();
    } 

    final response = await processResponse(urlFinal);

    return response;

  }

  Future<CreditsDetailsModel> processResponse(String url) async{

    print("Url Credits : $url");

    final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){

      final decodedData = json.decode(response.body);

      final credits = CreditsDetailsModel.fromJson(decodedData);

      return credits;

    }else{

      throw ServerException();

    }

  }

}