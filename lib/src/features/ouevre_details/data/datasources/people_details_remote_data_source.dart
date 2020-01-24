
import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'package:meta/meta.dart';

import 'package:bunkalist/src/features/ouevre_details/data/models/people_details_model.dart';

abstract class PeopleDetailsRemoteDataSource{

  /// Calls the http://themoviedb.org/3/person/{person_id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<PeopleModel> getPeopleDetails(int id);
}


class PeopleDetailsRemoteDataSourceImpl implements PeopleDetailsRemoteDataSource{
  
  final http.Client client;

  PeopleDetailsRemoteDataSourceImpl({@required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  Preferences prefs = new Preferences();

  @override
  Future<PeopleModel> getPeopleDetails(int id) async {
    
    final Map<String, String> _query = {
      'api_key' : _theMovieDB,
      'language': prefs.getLanguage.toString()
    };

    final url = Uri.https(_url, '/3/person/$id', _query);

    final resp = await processResponse(url.toString());

    return resp;

  }

  Future<PeopleModel> processResponse(String url)  async {

    print("Url People Details : $url");

     final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      
      final decodedData = json.decode(response.body);

      final peopleDetails = PeopleModel.fromJson(decodedData);

      return peopleDetails; 
    }else{

      throw ServerException();

    } 

  }

}