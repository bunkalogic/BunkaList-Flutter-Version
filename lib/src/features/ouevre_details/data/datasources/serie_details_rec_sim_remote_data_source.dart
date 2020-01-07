import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:http/http.dart' as http ;
import 'package:meta/meta.dart';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/serie_details_rs_model.dart';


abstract class SeriesRecommendationAndSimilarRemoteDataSource{
  /// Calls the http://theMoviedb.org/3/tv/{tv_id}/recommendations endpoint.
  /// &
  /// Calls the http://theMoviedb.org/3/tv/{tv_id}/similar endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
   
  Future<List<SeriesModelRS>> getSeriesRecommedations(int id);

  Future<List<SeriesModelRS>> getSeriesSimilar(int id);

}

class SeriesRecommendationAndSimilarRemoteDataSourceImpl implements SeriesRecommendationAndSimilarRemoteDataSource{
  

  final http.Client client;

  SeriesRecommendationAndSimilarRemoteDataSourceImpl({@required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  Preferences prefs = new Preferences();

  @override
  Future<List<SeriesModelRS>> getSeriesRecommedations(int id) async {
    
    final String url = createUrl('recommendations', id);

    final resp = await processResponse(url);

    return resp;

  }

  @override
  Future<List<SeriesModelRS>> getSeriesSimilar(int id) async {
    
    final String url = createUrl('similar', id);

    final resp = await processResponse(url);

    return resp;

  }

  String createUrl(String keyword, int id){
    
    final Map<String, String> _query = {
      'api_key'   : _theMovieDB,
      'language'  : prefs.getLanguage.toString()
    };

    final url = Uri.https(_url, '/3/tv/$id/$keyword', _query);

    return url.toString();
  }

  Future<List<SeriesModelRS>> processResponse(String url) async {

    print("Url Similar Or Recommmedations : $url");

    final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){

      final decodedData = json.decode(response.body);

      final listSeries = new Series.fromJsonList(decodedData['results']);

      if(listSeries.items.isNotEmpty){
        
        return listSeries.items;

      }else{

        return [];  

      }

    }else{
       
       throw ServerException();
       
    }

  }
  
  
  

}