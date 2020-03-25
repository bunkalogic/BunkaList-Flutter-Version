import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:http/http.dart';



  Preferences prefs = new Preferences();
  final _url        = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;

  Future<String> getUserGuestSessionId(Client client) async {
    

    final url = Uri.https(_url, '/3/authentication/guest_session/new',{
       'api_key' : _theMovieDB,
    });

    final resp = await processResponse(url.toString(), client);

    return resp;
  }

  Future<String> processResponse(String url, Client client) async{
    final response = await client.get(url,
       headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){

      final decodedData = json.decode(response.body);

      final guestSessionId = decodedData['guest_session_id'];
      print(guestSessionId);
      
      return guestSessionId;

    }else{

      throw ServerException();

    } 
  }