
import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http ;
import 'package:bunkalist/src/features/ouevre_details/data/models/episode_details_model.dart';

abstract class SeasonInfoDetailsRemoteDataSource {
  ///
  /// Calls the http://themoviedb.org/3/tv/{tv_id}/season/{season_number} endpoint.
  /// 
  
  Future<SeasonModel> getSeasonInfo(int id, int seasonId);
}

class SeasonInfoDetailsRemoteDataSourceImpl implements SeasonInfoDetailsRemoteDataSource{
  
  final http.Client client;

  SeasonInfoDetailsRemoteDataSourceImpl({ @required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  Preferences prefs = new Preferences();
  
  @override
  Future<SeasonModel> getSeasonInfo(int id, int seasonId) async {

      final Map<String, String> _query = {
        'api_key' : _theMovieDB,
        'language': prefs.getLanguage.toString()
      };

      final url = Uri.https(_url, '/3/tv/$id/season/$seasonId', _query);

      final resp = await processResponse(url.toString());

      return resp;
  }


  Future<SeasonModel> processResponse(String url) async {

    print("Url Season Info : $url");

    final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){

      final decodedData = json.decode(response.body);

      final season = new SeasonModel.fromJson(decodedData);

      return season;

    }else{
       
       throw ServerException();
       
    }

  }

}