
import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:bunkalist/src/core/constans/constans_genres_id.dart';
import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/home_tops/data/models/anime_model.dart';

import 'package:bunkalist/internal/keys.dart';


abstract class TopsAnimeRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<List<AnimeModel>> getTopsAnimes(int topId);

}

class TopsAnimeRemoteDataSourceImpl implements TopsAnimeRemoteDataSource  {
  
  final http.Client client;
  

  TopsAnimeRemoteDataSourceImpl({@required this.client});

  /// Calls the http://theAnimedb.org/3/discover/Anime endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Preferences prefs = new Preferences();
  
  
  final _url      = 'api.themoviedb.org';
  final _theAnimeDB = theMovieDbAPiKey;
  int   _page = 1;
  bool  _loading = false;
  

  Future<List<AnimeModel>>  getListAnimeFromApi({String sortBy, int voteCount, int voteAverage, String genres, String keywords,String airDate, String firstAirDate,}) async {
      if(_loading) return [];
      
      _loading = true;
      // carga y agrega un pagina
      //_page++;

      final Map<String, String> query = {
         'api_key'               : _theAnimeDB,
          'language'              : prefs.getLanguage,
          'page'                  : _page.toString(),
          'sort_by'               : sortBy,
          'air_date.lte'          : airDate,
          'first_air_date.gte'    : firstAirDate,
          'vote_count.gte'        : voteCount.toString(),
          'vote_average.gte'      : voteAverage.toString(),
          'with_genres'           : '16,$genres',
          'with_original_language': 'ja',
          'with_keywords'         : keywords
      };

      query.removeWhere((key , value) => value == null);
      query.removeWhere((key , value) => value == 'null');


      final url = Uri.https(
        _url, '3/discover/tv', query);

      
      
      final resp = await processResponse(url.toString());
      // deja de cargar 
      _loading = false;
      // retorna la lista de Anime
      return resp;

      
  }

  Future<List<AnimeModel>> processResponse(String url) async {
    print(url);
    final response = await client.get( url, 
      headers: { HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}
    );

    if(response.statusCode == 200){
      final decodedData = json.decode(response.body);
      print('Get Tops Anime total results: ${ decodedData['total_results'] }');

      final listAnime = new Animes.fromJsonList(decodedData['results']);

      if(listAnime.items.isNotEmpty){
        return listAnime.items;
      }else{
        return [];
      }
      
      

    }else{

      throw ServerException();

    }
    
  }
  
  
  
  @override
  Future<List<AnimeModel>> getTopsAnimes(int topId) async {
    switch (topId) {

      case Constants.topsAnimePopularId            : return await getListAnimeFromApi(sortBy: ConstSortBy.popularityDesc);

      case Constants.topsAnimeRatedId              : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, voteCount: 45);

      case Constants.topsAnimeSeasonId             : return await getListAnimeFromApi(sortBy: ConstSortBy.popularityDesc, airDate: '2019-11-30', firstAirDate: '2019-09-01' );

      case Constants.topsAnimeUpcomingNextSeasonId : return await getListAnimeFromApi(sortBy: ConstSortBy.popularityDesc, airDate: '2020-02-28', firstAirDate: '2019-12-25' );

      case Constants.topsAnimeActionAndAdventureId : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.actionAndAveture.toString(), voteCount: 10 );

      case Constants.topsAnimeComedyId             : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.comedy.toString(), voteCount: 10 );
        
      case Constants.topsAnimeCrimenId             : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.crime.toString(), voteCount: 10 );
        
      case Constants.topsAnimeDramaId              : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.drama.toString(), voteCount: 10 );
        
      case Constants.topsAnimeMisteryId            : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.mistery.toString(), voteCount: 10 );
        
      case Constants.topsAnimeFantasyAndSciFiId    : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.sciFiAndFantasy.toString(), voteCount: 10);
        
      case Constants.topsAnimeWarAndPoliticsId     : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.warAndPolitics.toString(), voteCount: 10);
        
      case Constants.topsAnimeShonenId             : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, keywords: '207826');
        
      case Constants.topsAnimeSpokonId             : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, keywords: '6075');
        
      case Constants.topsAnimeMechaId              : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, keywords: '10046');
        
      case Constants.topsAnimeSliceOfLifeId        : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, keywords: '9914');
        
      case Constants.topsAnimeBasedOnMangaId       : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, keywords: '13141');
        
      case Constants.topsAnimeRomanceId            : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, keywords: '9840');
        
      case Constants.topsAnimeSuperNaturalId       : return await getListAnimeFromApi(sortBy: ConstSortBy.voteAverageDesc, keywords: '6152');
        


          
      
      

      default: return null;
    }
  }



}