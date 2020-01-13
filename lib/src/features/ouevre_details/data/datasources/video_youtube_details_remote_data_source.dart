import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'package:meta/meta.dart';

import 'package:bunkalist/src/features/ouevre_details/data/models/youtube_video_datails_model.dart';

abstract class VideoYoutubeDetailsRemoteDataSource{
  /// Calls the https://www.googleapis.com/youtube/v3/search endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<List<VideoYoutubeModel>> getListVideoYoutube(String query); 
  
}


class VideoYoutubeDetailsRemoteDataSourceImpl implements VideoYoutubeDetailsRemoteDataSource{
  
   final http.Client client;

   VideoYoutubeDetailsRemoteDataSourceImpl({@required this.client});

   final String _baseUrl = 'www.googleapis.com';
   final _key = youtubeAPIKey;
   Preferences prefs = new Preferences();
  
  
  @override
  Future<List<VideoYoutubeModel>> getListVideoYoutube(String query) async {
    
    Map<String, String> parameters = {
      'part'              : 'snippet',
      'maxResults'        : '12',
      'relevanceLanguage' : prefs.getLanguage,
      'type'              : 'video',
      'q'                 : query,
      'key'               : _key,
    };

    final url  = Uri.https(_baseUrl, '/youtube/v3/search', parameters);

    final resp = await proccessResponse(url.toString());


    return resp;
  }

  Future<List<VideoYoutubeModel>> proccessResponse(String url) async {
    print('Videos Youtube Url: $url');

    final response = await client.get(url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){

      final decodedData = json.decode(response.body);

      print(decodedData);

      final listVideoYoutube = new ListVideosYoutube.fromJsonList(decodedData['items']);

      if(listVideoYoutube.items.isNotEmpty){
        
        return listVideoYoutube.items;

      }else{
        return [];
      }

    }else{

       throw ServerException();

    }

  }

}