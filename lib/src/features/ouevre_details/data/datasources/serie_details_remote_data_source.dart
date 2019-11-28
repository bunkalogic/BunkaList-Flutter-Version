

import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/serie_details_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http ;


abstract class SerieDetailsRemoteDataSource {
  /// Calls the http://themoviedb.org/3/tv/{tv_id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<SerieDetailsModel> getSerieDetails(int id);
}

class SerieDetailsRemoteDataSourceImpl implements SerieDetailsRemoteDataSource{

  final http.Client client;

  SerieDetailsRemoteDataSourceImpl({@required this.client});
  

  Preferences prefs = new Preferences();
  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;

  
  
  
  @override
  Future<SerieDetailsModel> getSerieDetails(int id) async {
    
    final Map<String, String> _query = {
      'api_key' : _theMovieDB,
      'language': prefs.getLanguage.toString()
    };



    final url = Uri.https(_url, '/3/tv/$id', _query);

    final resp = await processResponse(url.toString());

    return resp;
  }

  Future<SerieDetailsModel> processResponse(String url) async{
    
    print(url);
    
    final response = await client.get(url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      
      final decodedData = json.decode(response.body);

      final serie = SerieDetailsModel.fromJson(decodedData);

      return serie;
      
    }else{

      throw ServerException();

    } 

  }

}