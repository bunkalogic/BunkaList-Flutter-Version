
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:meta/meta.dart';


class SerieDetailsModel extends SerieDetailsEntity {

  SerieDetailsModel({
    @required String backdropPath,
    @required List<dynamic> episodeRunTime,
    @required String firstAirDate,
    @required List<dynamic> genres,
    @required String homepage,
    @required int id,
    @required bool inProduction,
    @required List<dynamic> languages,
    @required String lastAirDate,
    @required String name,
    @required List<dynamic> networks,
    @required int numberOfEpisodes,
    @required int numberOfSeasons,
    @required List<dynamic> originCountry,
    @required String originalLanguage,
    @required String originalName,
    @required String overview,
    @required double popularity,
    @required String posterPath,
    @required String status,
    @required double voteAverage,
    @required int voteCount,
    String type,
  }) : super (
      backdropPath    :  backdropPath    ,
      episodeRunTime  :  episodeRunTime  ,
      firstAirDate    :  firstAirDate    ,
      genres          :  genres          ,
      homepage        :  homepage        ,
      id              :  id              ,
      inProduction    :  inProduction    ,
      languages       :  languages       ,
      lastAirDate     :  lastAirDate     ,
      name            :  name            ,
      networks        :  networks        ,
      numberOfEpisodes:  numberOfEpisodes,
      numberOfSeasons :  numberOfSeasons ,
      originCountry   :  originCountry   ,
      originalLanguage:  originalLanguage,
      originalName    :  originalName    ,
      overview        :  overview        ,
      popularity      :  popularity      ,
      posterPath      :  posterPath      ,
      status          :  status          ,
      voteAverage     :  voteAverage     ,
      voteCount       :  voteCount       ,
      type            :  'tv'            ,
  );

  factory SerieDetailsModel.fromJson(Map<String, dynamic> json){
    return SerieDetailsModel(
      backdropPath    : json['backdrop_path'],
      episodeRunTime  : json['episode_run_time'],
      firstAirDate    : json['first_air_date'],
      genres          : json['genres'],
      homepage        : json['homepage'],
      id              : json['id'],
      inProduction    : json['in_production'],
      languages       : json['languages'],
      lastAirDate     : json['last_air_date'],
      name            : json['name'],
      networks        : json['networks'],
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons : json['number_of_seasons'],
      originCountry   : json['origin_country'],
      originalLanguage: json['original_language'],
      originalName    : json['original_name'],
      overview        : json['overview'],
      popularity      : json['popularity'],
      posterPath      : json['poster_path'],
      status          : json['status'],
      voteAverage     : json['vote_average'],
      voteCount       : json['vote_count'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'backdrop_path'     : backdropPath    ,
      'episode_run_time'  : episodeRunTime  ,
      'first_air_date'    : firstAirDate    ,
      'genres'            : genres          ,
      'homepage'          : homepage        ,
      'id'                : id              ,
      'in_production'     : inProduction    ,
      'languages'         : languages       ,
      'last_air_date'     : lastAirDate     ,
      'name'              : name            ,
      'networks'          : networks        ,
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons' : numberOfSeasons ,
      'origin_country'    : originCountry   ,
      'original_language' : originalLanguage,
      'original_name'     : originalName    ,
      'overview'          : overview        ,
      'popularity'        : popularity      ,
      'poster_path'       : posterPath      ,
      'status'            : status          ,
      'vote_average'      : voteAverage     ,
      'vote_count'        : voteCount       ,
    };
  }



}