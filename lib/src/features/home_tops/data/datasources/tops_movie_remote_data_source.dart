import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/constans/constans_genres_id.dart';
import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:bunkalist/internal/keys.dart';

import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';

abstract class TopsMovieRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/movie endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  
  Future<List<MovieModel>> getTopsMovies(int topId);

}


class TopsMoviesRemoteDataSourceImpl implements TopsMovieRemoteDataSource  {
  
  final http.Client client;
  

  TopsMoviesRemoteDataSourceImpl({@required this.client});

  /// Calls the http://themoviedb.org/3/discover/movie endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Preferences prefs = new Preferences();
  
  
  final _url      = 'api.themoviedb.org';
  final _theMovieDB = theMovieDbAPiKey;
  int   _page = 1;
  bool  _loading = false;
  

  Future<List<MovieModel>>  getListMovieFromApi({String sortBy, int voteCount, int voteAverage, String genres}) async {
      if(_loading) return [];
      
      _loading = true;
      // carga y agrega un pagina
      // _page++

      final Map<String, String> query = {
          'api_key'         : _theMovieDB,
          'language'        : prefs.getLanguage,
          'page'            : _page.toString(),
          'sort_by'         : sortBy,
          'vote_count.gte'  : voteCount.toString(),
          'vote_average.gte': voteAverage.toString(),
          'with_genres'     : genres
      };

      

      query.removeWhere((key , value) => value == null);
      query.removeWhere((key , value) => value == 'null');

      final url = Uri.https(
        _url, '3/discover/movie', query);
      

      final resp = await processResponse(url.toString());
      // deja de cargar 
      _loading = false;
      // retorna la lista de movies
      return resp;

      
  }

  Future<List<MovieModel>> processResponse(String url) async {
    print(url);
    final response = await client.get( url, 
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body);
      print('Get Tops Movies total results: ${ decodedData['total_results'] }');

      final listMovies = new Movies.fromJsonList(decodedData['results']);

      if(listMovies.items.isNotEmpty){
        return listMovies.items;
      }else{
        return[];
      }
      
      

    }else{

      throw ServerException();

    }
    
  }
  
  
  
  @override
  Future<List<MovieModel>> getTopsMovies(int topId) async {
    switch (topId) {

      case Constants.topsMoviesPopularId        : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc);

      case Constants.topsMoviesRatedId          : return await getListMovieFromApi(sortBy: ConstSortBy.voteAverageDesc, voteCount: 2800);

      case Constants.topsMoviesUpcommingId      : return await getListMovieFromApi(sortBy: ConstSortBy.primaryReleaseDateDesc);

      case Constants.topsMoviesActionId         : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.action.toString());

      case Constants.topsMoviesAdventureId      : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.adventure.toString());

      case Constants.topsMoviesComedyId         : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.comedy.toString());

      case Constants.topsMoviesWarId            : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.war.toString());

      case Constants.topsMoviesScienceFictionId : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.sciFi.toString());

      case Constants.topsMoviesCrimeId          : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.crime.toString());

      case Constants.topsMoviesDocumentalId     : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.documentary.toString());

      case Constants.topsMoviesDramaId          : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.drama.toString());

      case Constants.topsMoviesFamilyId         : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.family.toString());

      case Constants.topsMoviesFantasyId        : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.fantasy.toString());

      case Constants.topsMoviesHistoryId        : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.history.toString());

      case Constants.topsMoviesMisteryId        : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.mistery.toString());

      case Constants.topsMoviesMusicalId        : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.music.toString());

      case Constants.topsMoviesRomanceId        : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.romance.toString());

      case Constants.topsMoviesThillerId        : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.thriller.toString());

      case Constants.topsMoviesTerrorId         : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.horror.toString());

      case Constants.topsMoviesWesternId        : return await getListMovieFromApi(sortBy: ConstSortBy.popularityDesc, genres: ConstGenres.western.toString());

      default: return null;
    }
  }



}