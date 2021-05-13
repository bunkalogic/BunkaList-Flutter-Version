
import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/anime_details_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http ;

abstract class AnimeDetailsRemoteDataSource {
  /// Calls the http://themoviedb.org/3/tv/{tv_id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<AnimeDetailsModel> getAnimeDetails(int id);
}


class AnimeDetailsRemoteDataSourceImpl implements AnimeDetailsRemoteDataSource {

  final http.Client client;

  AnimeDetailsRemoteDataSourceImpl({@required this.client});
  

  Preferences prefs = new Preferences();
  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;

  
  
  
  @override
  Future<AnimeDetailsModel> getAnimeDetails(int id) async {
    
    final url = Uri.https(_url, '/3/tv/$id', {
      'api_key' : _theMovieDB,
      'language': prefs.getLanguage.toString()
    });

    final resp = await processResponse(url.toString());

    return resp;
  }

  Future<AnimeDetailsModel> processResponse(String url) async{
    
    print(url);
    
    final response = await client.get(url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      
      final decodedData = json.decode(response.body);

      final anime = AnimeDetailsModel.fromJson(decodedData);

      return anime;
      
    }else{

      throw ServerException();

    } 

  }

}