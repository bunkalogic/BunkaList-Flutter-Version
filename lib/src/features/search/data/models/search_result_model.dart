import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';

class ResultsModel extends ResultsEntity {

  ResultsModel({
    @required int page,
    @required List<dynamic> results,
    @required int totalResults,
    @required int totalPages,
  }) : super(
    page          : page,
    results       : results,
    totalResults  : totalResults,
    totalPages    : totalPages,
  ); 

  factory ResultsModel.fromJson(Map<String, dynamic> json){

    var listResults = json['results'] as List;
    List<ResultModel> resultList = listResults.map((i) => ResultModel.fromJson(i)).toList();

    return ResultsModel(
      page          : json['page'],
      results       : resultList,
      totalResults  : json['total_results'],
      totalPages    : json['total_pages'],
    );
  }
}

class ResultModel extends Result{

  ResultModel({
    @required String posterPath,
    @required double popularity,
    @required int id,
    @required String overview,
    @required String backdropPath,
    @required double voteAverage,
    @required String mediaType,
    @required String firstAirDate,
    @required List<dynamic> genreIds,
    @required int voteCount,
    @required String name,
    @required String originalName,
    @required DateTime releaseDate,
    @required String originalTitle,
    @required String title,
    @required String profilePath,
  }) : super (
    posterPath    : posterPath,
    popularity    : popularity,
    id            : id,
    overview      : overview,
    backdropPath  : backdropPath,
    voteAverage   : voteAverage,
    mediaType     : mediaType,
    firstAirDate  : firstAirDate,
    genreIds      : genreIds,
    voteCount     : voteCount,
    name          : name,
    originalName  : originalName,
    releaseDate   : releaseDate,
    originalTitle : originalTitle,
    title         : title,
    profilePath   : profilePath,
  );

  factory ResultModel.fromJson(Map<String, dynamic> json){
      
      final String type =   json['media_type'] as String;
      String typeFinal;

      if(type != 'movie' && type != 'person'){
        
        var listGenre = json['genre_ids'] as List;
         
        final whatTypeIs = listGenre.contains(16);

        (whatTypeIs) ?  typeFinal = 'anime' : typeFinal = 'tv';
   
      }else if(type == 'movie'){
        typeFinal = 'movie';
      }else if(type == 'person'){
        typeFinal = 'person';
      }

      return ResultModel(
        posterPath    : json['poster_path'],
        popularity    : json['popularity'] / 1,
        id            : json['id'],
        overview      : json['overview'],
        backdropPath  : json['backdropPath'],
        voteAverage   : json['voteAverage'] / 1,
        mediaType     : typeFinal,
        firstAirDate  : json['first_air_date'],
        genreIds      : json['genre_ids'],
        voteCount     : json['vote_count'],
        name          : json['name'],
        originalName  : json['original_name'],
        releaseDate   : json['release_date'],
        originalTitle : json['original_title'],
        title         : json['title'],
        profilePath   : json['profile_path'],
      );
  }

}