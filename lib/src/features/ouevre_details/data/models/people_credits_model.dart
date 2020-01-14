
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_credits_entity.dart';

class PeopleCreditsModel extends PeopleCreditsEntity{

  PeopleCreditsModel({
    @required List<dynamic> cast,
    @required List<dynamic> crew,
    @required int id,
  }) : super (
    cast  : cast, 
    crew  : crew,
    id    : id,
  );

  factory PeopleCreditsModel.fromJson(Map<String, dynamic> json){

     var listCast = json['cast'] as List;
      List<CastAndCrewModel> castList = listCast.map((i) => CastAndCrewModel.fromJson(i)).toList();

      var listCrew = json['crew'] as List;
      List<CastAndCrewModel> crewList = listCrew.map((i) => CastAndCrewModel.fromJson(i)).toList(); 
    
    return PeopleCreditsModel(
      cast : castList,
      crew : crewList,
      id   : json['id'],   
    );
  }
}

class CastAndCrewModel extends CastAndCrew {

  CastAndCrewModel({
    @required int id,
    @required String character,
    @required String originalTitle,
    @required String overview,
    @required int voteCount,
    @required bool video,
    @required String mediaType,
    @required String releaseDate,
    @required double voteAverage,
    @required String title,
    @required double popularity,
    @required String originalLanguage,
    @required List<dynamic> genreIds,
    @required String backdropPath,
    @required bool adult,
    @required String posterPath,
    @required String creditId,
    @required int episodeCount,
    @required List<dynamic> originCountry,
    @required String originalName,
    @required String name,
    @required String firstAirDate,
    @required String department,
    @required String job,
  }) : super(
    id               :  id,                  
    character        :  character,
    originalTitle    :  originalTitle,
    overview         :  overview,
    voteCount        :  voteCount,
    video            :  video,
    mediaType        :  mediaType,
    releaseDate      :  releaseDate,
    voteAverage      :  voteAverage,
    title            :  title,
    popularity       :  popularity,
    originalLanguage :  originalLanguage,
    genreIds         :  genreIds,
    backdropPath     :  backdropPath,
    adult            :  adult,
    posterPath       :  posterPath,
    creditId         :  creditId,
    episodeCount     :  episodeCount,
    originCountry    :  originCountry,
    originalName     :  originalName,
    name             :  name,
    firstAirDate     :  firstAirDate,
    department       :  department,
    job              :  job,
  );

  factory CastAndCrewModel.fromJson(Map<String, dynamic> json){

      final String type =   json['media_type'] as String;
      String typeFinal;

      if(type != 'movie'){
        
        var listGenre = json['genre_ids'] as List;
         
        final whatTypeIs = listGenre.contains(16);

        (whatTypeIs) ?  typeFinal = 'anime' : typeFinal = 'tv';
   
      }else{
        typeFinal = 'movie';
      }
      print('is type: ' + typeFinal);
      

      return CastAndCrewModel(
        id               :  json['id'],                  
        character        :  json['character'],
        originalTitle    :  json['original_title'],
        overview         :  json['overview'],
        voteCount        :  json['vote_count'],
        video            :  json['video'],
        mediaType        :  typeFinal,
        releaseDate      :  json['release_date'],
        voteAverage      :  json['vote_average'] / 1,
        title            :  json['title'],
        popularity       :  json['popularity'] / 1,
        originalLanguage :  json['original_language'],
        genreIds         :  json['genre_ids'],
        backdropPath     :  json['backdrop_path'],
        adult            :  json['adult'],
        posterPath       :  json['poster_path'],
        creditId         :  json['credit_id'],
        episodeCount     :  json['episode_count'],
        originCountry    :  json['origin_country'],
        originalName     :  json['original_name'],
        name             :  json['name'],
        firstAirDate     :  json['first_air_date'],
        department       :  json['department'],
        job              :  json['job'],
      );
  }
}