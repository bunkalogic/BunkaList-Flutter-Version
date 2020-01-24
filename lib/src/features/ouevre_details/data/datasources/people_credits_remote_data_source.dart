
import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'package:meta/meta.dart';

import 'package:bunkalist/src/features/ouevre_details/data/models/people_credits_model.dart';

abstract class PeopleCreditsRemoteDataSource{

  /// Calls the http://themoviedb.org/3/person/{person_id}/combined_credits endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<PeopleCreditsModel> getPeopleCredits(int id);
}


class PeopleCreditsRemoteDataSourceImpl implements PeopleCreditsRemoteDataSource{
  
  final http.Client client;

  PeopleCreditsRemoteDataSourceImpl({@required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  Preferences prefs = new Preferences();
  
  @override
  Future<PeopleCreditsModel> getPeopleCredits(int id) async {
    final Map<String, String> _query = {
      'api_key' : _theMovieDB,
      'language': prefs.getLanguage.toString()
    };

    final url = Uri.https(_url, '/3/person/$id/combined_credits', _query);

    final resp = await processResponse(url.toString());

    return resp;
  }

  Future<PeopleCreditsModel> processResponse(String url)  async {

    print("Url People Credits : $url");

     final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      
      final decodedData = json.decode(response.body);

      final peopleDetails = PeopleCreditsModel.fromJson(decodedData);

      return peopleDetails; 
    }else{

      throw ServerException();

    } 

  }

}