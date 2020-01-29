import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http ;
import 'package:bunkalist/src/features/search/data/models/search_result_model.dart';

abstract class SearchResultRemoteDataSource{
  /// 
  /// Calls the http://themoviedb.org/3/search/multi endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<ResultsModel> getSearchResult(String query);
  
}

class SearchResultRemoteDataSourceImpl implements SearchResultRemoteDataSource{
  
  
  final http.Client client;

  SearchResultRemoteDataSourceImpl({@required this.client });

  Preferences prefs = new Preferences();
  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  
  
  @override
  Future<ResultsModel> getSearchResult(String query) async {
    
    final Map<String, String> _query = {
      'api_key' : _theMovieDB,
      'language': prefs.getLanguage.toString()
    };

    final url = Uri.https(_url, '/3/search/multi', _query);

    final resp = await processResponse(url.toString());

    return resp;

  }

  Future<ResultsModel> processResponse(String url) async {
    print('Url MultiSearch: $url');

    final response = await client.get(url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

      if(response.statusCode == 200){

        final decodedData = json.decode(response.body);

        final search = ResultsModel.fromJson(decodedData);

        return search;

      }else{

      throw ServerException();

    } 
  }

}