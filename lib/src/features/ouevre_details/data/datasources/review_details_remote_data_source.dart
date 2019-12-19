import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/internal/keys.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:http/http.dart' as http ;
import 'package:meta/meta.dart';

import 'package:bunkalist/src/features/ouevre_details/data/models/review_details_model.dart';

abstract class ReviewDetailsRemoteDataSource{
  /// Calls the http://themoviedb.org/3/movie/{movie_id}/reviews endpoint.
  /// 
  /// Calls the http://themoviedb.org/3/tv/{tv_id}/reviews endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<List<ReviewModel>> getReviews(int id, String type);
}

class ReviewDetailsRemoteDataSourceImpl implements ReviewDetailsRemoteDataSource{
  
  final http.Client client;

  ReviewDetailsRemoteDataSourceImpl({@required this.client});

  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  
  
  @override
  Future<List<ReviewModel>> getReviews(int id, String type) async {

    String urlFinal;

    final Map<String, String> _query = {
      'api_key' : _theMovieDB,
    };

    if(type == 'movie'){

      final url = Uri.https(_url, '/3/movie/$id/reviews', _query);

      urlFinal = url.toString();

    }else if(type == 'tv' || type == 'anime'){

      final url = Uri.https(_url, '/3/tv/$id/reviews', _query);

      urlFinal = url.toString();
    }

    final response = await processResponse(urlFinal);

    return response;

  }

  Future<List<ReviewModel>> processResponse(String url) async {

    print("Url Review : $url");

    final response = await client.get( url,
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){

      final decodedData = json.decode(response.body);

      final listReviews = new Reviews.fromJsonList(decodedData['results']);

      if(listReviews.items.isNotEmpty){
        
        return listReviews.items;

      }else{

        return [];  

      }

    }else{
       
       throw ServerException();
       
    }

  }

}