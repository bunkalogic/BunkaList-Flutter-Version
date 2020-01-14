

import 'dart:convert';
import 'dart:io';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http ;
import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/people_social_media_model.dart';

abstract class PeopleSocialMediaRemoteDataSource{

  /// Calls the http://themoviedb.org/3/person/{person_id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<PeopleSocialMediaModel> getPeopleSocialMedia(int id);
}

class PeopleSocialMediaRemoteDataSourceImpl implements PeopleSocialMediaRemoteDataSource{
  
  final http.Client client;

  PeopleSocialMediaRemoteDataSourceImpl({@required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  Preferences prefs = new Preferences();

  @override
  Future<PeopleSocialMediaModel> getPeopleSocialMedia(int id) async {
    
    final Map<String, String> _query = {
      'api_key' : _theMovieDB,
      'language': prefs.getLanguage.toString()
    };

    final url = Uri.https(_url, '/3/people/$id/external_ids', _query);

    final resp = await processResponse(url.toString());

    return resp;

  }

  Future<PeopleSocialMediaModel>  processResponse(String url)  async {

    print("Url People Social Media : $url");

     final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      
      final decodedData = json.decode(response.body);

      final peopleDetails = PeopleSocialMediaModel.fromJson(decodedData);

      return peopleDetails; 
    }else{

      throw ServerException();

    } 

  }

}