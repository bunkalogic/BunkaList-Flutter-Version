
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

  Future<List<AnimeModel>> getTopsAnimes(int topId, int page);

}

class TopsAnimeRemoteDataSourceImpl implements TopsAnimeRemoteDataSource  {
  
  final http.Client client;
  

  TopsAnimeRemoteDataSourceImpl({@required this.client});

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Preferences prefs = new Preferences();
  
  
  final _url      = 'api.themoviedb.org';
  final _theAnimeDB = theMovieDbAPiKey;
  bool  _loading = false;
  int totalPage = 1;
  

  Future<List<AnimeModel>>  getListAnimeFromApi(int page, {String sortBy, int voteCount, int voteAverage, String genres, String keywords,String airDate, String firstAirDate, String airDateGte}) async {
      if(_loading) return [];
      
      _loading = true;
      
     // esto se encarga de que la pagina no supere la total page
      page = (page <= totalPage) ? page : totalPage;

      // esto se encarga de que la page no sea inferior a 1 
      final _page = (page == 0) ? 1 : page;

      final Map<String, String> query = {
         'api_key'               : _theAnimeDB,
          'language'              : prefs.getLanguage,
          'page'                  : _page.toString(),
          'sort_by'               : sortBy,
          'air_date.gte'          : airDateGte,
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


  Future<List<AnimeModel>>  getListAnimesSelection(int page) async {
    final listIdVol1 = 145397;
    final listIdVol2 = 7064704;

    List<int> recListVol = List<int>();

    recListVol.add(listIdVol1);  
    recListVol.add(listIdVol2);

    recListVol.shuffle();

    final int id = recListVol[1];

    final Map<String, String> query = {
        'api_key'                   : _theAnimeDB,
        'language'                  : prefs.getLanguage,
        'page'                      : page.toString(),
        'sort_by'                   : "vote_average.desc"
    };
    
    final url = Uri.https(
      _url, '4/list/$id', query);
    
    final resp = await processResponse(url.toString(),);
    
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

      totalPage = decodedData['total_pages'];

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
  Future<List<AnimeModel>> getTopsAnimes(int topId, int page) async {
    switch (topId) {

      case Constants.topsAnimePopularId            : return await getListAnimeFromApi(page, sortBy: ConstSortBy.popularityDesc);

      case Constants.topsAnimeRatedId              : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, voteCount: 35);

      case Constants.topsAnimeSeasonId             : return await getListAnimeFromApi(page, sortBy: ConstSortBy.popularityDesc, airDateGte: '2020-10-01', airDate: '2020-11-01' );

      case Constants.topsAnimeUpcomingNextSeasonId : return await getListAnimeFromApi(page, sortBy: ConstSortBy.popularityDesc, airDateGte: '2020-12-30', airDate: '2021-01-01' );

      case Constants.topsAnimeActionAndAdventureId : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.actionAndAveture.toString(), voteCount: 5 );

      case Constants.topsAnimeComedyId             : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.comedy.toString(), voteCount: 5 );
        
      case Constants.topsAnimeCrimenId             : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.crime.toString(), voteCount: 1 );
        
      case Constants.topsAnimeDramaId              : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.drama.toString(), voteCount: 3 );
        
      case Constants.topsAnimeMisteryId            : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.mistery.toString(), voteCount: 3 );
        
      case Constants.topsAnimeFantasyAndSciFiId    : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.sciFiAndFantasy.toString(), voteCount: 3);
        
      case Constants.topsAnimeWarAndPoliticsId     : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, genres: ConstGenres.warAndPolitics.toString(),);
        
      case Constants.topsAnimeShonenId             : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, keywords: '207826');
        
      case Constants.topsAnimeSpokonId             : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, keywords: '6075');
        
      case Constants.topsAnimeMechaId              : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, keywords: '10046');
        
      case Constants.topsAnimeSliceOfLifeId        : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, keywords: '9914');
        
      case Constants.topsAnimeBasedOnMangaId       : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, keywords: '13141');
        
      case Constants.topsAnimeRomanceId            : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, keywords: '9840');
        
      case Constants.topsAnimeSuperNaturalId       : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, keywords: '6152');

      case Constants.topsAnimeSeasonAirId          : return await getListAnimeFromApi(page, sortBy: ConstSortBy.popularityDesc, firstAirDate: '2021-01-01', airDate: '2021-01-30' );
      
      case Constants.topsAnimesSeinen              : return await getListAnimeFromApi(page, sortBy: ConstSortBy.voteAverageDesc, keywords: '195668');

      case Constants.selectionAnimesId  : return await getListAnimesSelection(page);
      

      default: return null;
    }
  }



}