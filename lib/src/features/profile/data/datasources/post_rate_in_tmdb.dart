
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void postRateTMDb(String ouevreId, String type, double rating) async {

  Preferences prefs = new Preferences();
  final _url        = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;

  final String rateJson = '{"value": $rating}';

  if(type == 'movie'){
    final url = Uri.https(_url, '/3/movie/$ouevreId/rating',{
      'api_key' : _theMovieDB,
      'guest_session_id' : prefs.getGuestSessionId
    });

    await processResponse(url.toString(), rateJson);

  }else if(type == 'tv' || type == 'anime'){
    final url = Uri.https(_url, '/3/tv/$ouevreId/rating',{
      'api_key' : _theMovieDB,
      'guest_session_id' : prefs.getGuestSessionId
    });

    await processResponse(url.toString(), rateJson);
  }

}


Future<void> processResponse(String url, String rate) async {
  
  final response = await http.post(url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      body: rate
  );

  int statusCode = response.statusCode;

  if(statusCode == 201){
    print('Obra puntuada de forma correcta');
  }else{
    print('Obra no ha sido puntuada de forma correcta');
  }
}