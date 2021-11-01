
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
    @required List<dynamic> seasonSerie,
    @required List<dynamic> productionCompanies,
    @required dynamic lastEpisodeToAir,
    @required dynamic nextEpisodeToAir,
    @required List<dynamic> spokenLanguage,
    @required List<dynamic> productionCountry,
    @required List<dynamic> createdBy,
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
      seasonSerie     :  seasonSerie     ,
      type            :  'tv'            ,
      productionCompanies: productionCompanies,
      lastEpisodeToAir: lastEpisodeToAir,
      nextEpisodeToAir:  nextEpisodeToAir,
      productionCountry: productionCountry,
      spokenLanguage: spokenLanguage, 
      createdBy: createdBy
  );

  factory SerieDetailsModel.fromJson(Map<String, dynamic> json){

    var listGenre = json['genres'] as List;
    List<GenreSerieModel> genreItems = listGenre.map((i) => GenreSerieModel.fromJson(i)).toList();

    var listNetworks = json['networks'] as List;
    List<NetworkSerieModel> networkItems = listNetworks.map((i) => NetworkSerieModel.fromJson(i)).toList();

    var listSeasons = json['seasons'] as List;
    List<SeasonSerieModel> seasonItems = listSeasons.map((i) => SeasonSerieModel.fromJson(i)).toList();

    var listProducer = json['production_companies'] as List;
    List<SerieProductionCompanyModel> producerItems = listProducer.map((i) => SerieProductionCompanyModel.fromJson(i)).toList();

    var listLastEpisodeToAir = json['last_episode_to_air'];
    SerieLastEpisodeToAirModel lastEpisode = listLastEpisodeToAir != null ? SerieLastEpisodeToAirModel.fromJson(listLastEpisodeToAir) : SerieLastEpisodeToAirModel(airDate: 'no data', episodeNumber: -1, id: -1, name: 'no data', overview: 'no data', productionCode: '', seasonNumber: -1, stillPath: '', voteAverage: 0.0,  voteCount: -1);

    var listNextEpisodeToAir = json['next_episode_to_air'];
    SerieLastEpisodeToAirModel nextEpisode = listNextEpisodeToAir != null ? SerieLastEpisodeToAirModel.fromJson(listNextEpisodeToAir) : SerieLastEpisodeToAirModel(airDate: 'no data', episodeNumber: -1, id: -1, name: 'no data', overview: 'no data', productionCode: '', seasonNumber: -1, stillPath: '', voteAverage: 0.0,  voteCount: -1);

    var spokenLanguage = json['spoken_languages'] as List;
    List<SerieSpokenLanguagesModel> itemSpokenLanguages = spokenLanguage.map((i) => SerieSpokenLanguagesModel.fromJson(i)).toList();

    var countryProduction = json['production_countries'] as List;
    List<SerieProductionsCountryModel> itemProductionCountry  = countryProduction.map((i) => SerieProductionsCountryModel.fromJson(i)).toList();

    var createdBy = json['created_by'] as List;
    List<SerieCreatedByModel> itemCreatedBy = createdBy.map((i) => SerieCreatedByModel.fromJson(i)).toList();


    return SerieDetailsModel(
      backdropPath    : json['backdrop_path'],
      episodeRunTime  : json['episode_run_time'],
      firstAirDate    : json['first_air_date'],
      genres          : genreItems,
      homepage        : json['homepage'],
      id              : json['id'],
      inProduction    : json['in_production'],
      languages       : json['languages'],
      lastAirDate     : json['last_air_date'],
      name            : json['name'],
      networks        : networkItems,
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
      seasonSerie     : seasonItems,
      productionCompanies: producerItems,
      lastEpisodeToAir: lastEpisode,
      nextEpisodeToAir: nextEpisode,
      spokenLanguage: itemSpokenLanguages,
      productionCountry: itemProductionCountry,
      createdBy: itemCreatedBy
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
      'seasons'           : seasonSerie     ,
      'production_companies': productionCompanies,
      'last_episode_to_air': lastEpisodeToAir,
      'spoken_languages' : spokenLanguage,
      'production_countries' : productionCountry,
      'created_by' : createdBy
    };
  }
}

class SeasonSerieModel extends SeasonSerie {

  SeasonSerieModel({
    @required String airDate,
    @required int episodeCount,
    @required int id,
    @required String name,
    @required String overview,
    @required String posterPath,
    @required int seasonNumber,
  }) : super (
      airDate      :airDate ,
      episodeCount :episodeCount ,
      id           :id ,
      name         :name ,
      overview     :overview ,
      posterPath   :posterPath ,
      seasonNumber :seasonNumber , 
  );

  factory SeasonSerieModel.fromJson(Map<String, dynamic> json){
     return SeasonSerieModel(
          airDate      :json['air_date'],
          episodeCount :json['episode_count'] ,
          id           :json['id'] ,
          name         :json['name'] ,
          overview     :json['overview'] ,
          posterPath   :json['poster_path'] ,
          seasonNumber :json['season_number'] , 
     );

  }

   Map<String, dynamic> toJson(){
     return{

      'air_date'      : airDate,
      'episode_count' : episodeCount,
      'id'            : id,
      'name'          : name,
      'overview'      : overview,
      'poster_path'   : posterPath,
      'season_number' : seasonNumber,

     };
   }

}

class GenreSerieModel extends GenreSerie{
  GenreSerieModel({
    @required int id,
    @required String name,
  }) : super (
      id           :id ,
      name         :name , 
  );

  factory GenreSerieModel.fromJson(Map<String, dynamic> json){
     return GenreSerieModel(
          id           :json['id'] ,
          name         :json['name'] , 
     );

  }

   Map<String, dynamic> toJson(){
     return{
      'id'            : id,
      'name'          : name,
     };
   }
}

class NetworkSerieModel extends NetworkSerie{
  NetworkSerieModel({
    @required int id,
    @required String name,
    @required String logoPath,
    @required String originCountry,
  }) : super (
      id           :id ,
      name         :name ,
      logoPath     :logoPath,
      originCountry : originCountry,
  );

  factory NetworkSerieModel.fromJson(Map<String, dynamic> json){
     return NetworkSerieModel(
          id           :  json['id'],
          name         :  json['name'],
          logoPath     :  json['logo_path'],
          originCountry:  json['origin_country']  
     );

  }

   Map<String, dynamic> toJson(){
     return{
      'id'            : id,
      'name'          : name,
      'logo_path'     : logoPath,
      'origin_country': originCountry
     };
   }
}


class SerieProductionCompanyModel extends SerieProductionCompany {
    SerieProductionCompanyModel({
        @required this.id,
        @required this.logoPath,
        @required this.name,
        @required this.originCountry,
    });

    final int id;
    final String logoPath;
    final String name;
    final String originCountry;

    

    factory SerieProductionCompanyModel.fromJson(Map<String, dynamic> json) => SerieProductionCompanyModel(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}



class SerieLastEpisodeToAirModel extends SerieLastEpisodeToAir {
    SerieLastEpisodeToAirModel({
        @required this.airDate,
        @required this.episodeNumber,
        @required this.id,
        @required this.name,
        @required this.overview,
        @required this.productionCode,
        @required this.seasonNumber,
        @required this.stillPath,
        @required this.voteAverage,
        @required this.voteCount,
    });

    final String airDate;
    final int episodeNumber;
    final int id;
    final String name;
    final String overview;
    final String productionCode;
    final int seasonNumber;
    final String stillPath;
    final double voteAverage;
    final int voteCount;


    factory SerieLastEpisodeToAirModel.fromJson(Map<String, dynamic> json) => SerieLastEpisodeToAirModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}



class SerieProductionsCountryModel extends SerieProductionCountry{
    SerieProductionsCountryModel({
        @required this.iso31661,
        @required this.name,
    });

    final String iso31661;
    final String name;


    factory SerieProductionsCountryModel.fromJson(Map<String, dynamic> json) => SerieProductionsCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}


class SerieSpokenLanguagesModel  extends SerieSpokenLanguage{
    SerieSpokenLanguagesModel({
        @required this.englishName,
        @required this.iso6391,
        @required this.name,
    });

    final String englishName;
    final String iso6391;
    final String name;

    

    factory SerieSpokenLanguagesModel.fromJson(Map<String, dynamic> json) => SerieSpokenLanguagesModel(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}


class SerieCreatedByModel extends SerieCreatedBy{
    SerieCreatedByModel({
        @required this.id,
        @required this.creditId,
        @required this.name,
        @required this.gender,
        @required this.profilePath,
    });

    final int id;
    final String creditId;
    final String name;
    final int gender;
    final String profilePath;

    
    factory SerieCreatedByModel.fromJson(Map<String, dynamic> json) => SerieCreatedByModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
    };
}

