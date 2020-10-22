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
    String posterPath,
    double popularity,
    int id,
    String overview,
    String backdropPath,
    double voteAverage,
    String mediaType,
    String firstAirDate,
    List<dynamic> genreIds,
    int voteCount,
    String name,
    String originalName,
    String releaseDate,
    String originalTitle,
    String title,
    String profilePath,
    String knownForDepartment,
    int gender,
    List<dynamic> knownFor
  }) : super (
    posterPath        : posterPath,
    popularity        : popularity,
    id                : id,
    overview          : overview,
    backdropPath      : backdropPath,
    voteAverage       : voteAverage,
    mediaType         : mediaType,
    firstAirDate      : firstAirDate,
    genreIds          : genreIds,
    voteCount         : voteCount,
    name              : name,
    originalName      : originalName,
    releaseDate       : releaseDate,
    originalTitle     : originalTitle,
    title             : title,
    profilePath       : profilePath,
    knownForDepartment: knownForDepartment,
    gender            : gender,
    knownFor          : knownFor
  );

  factory ResultModel.fromJson(Map<String, dynamic> json){
      
      final String type = json['media_type'] as String;
      String typeFinal;

      // if(type != 'movie' && type != 'person'){
        
      //   var listGenre = json['genre_ids'] as List;
         
      //   final whatTypeIs = listGenre.contains(16);

      //   (whatTypeIs) ?  typeFinal = 'anime' : typeFinal = 'tv';
   
      // } 

      if(type == 'person'){ 
        typeFinal = 'person';

        return ResultModel(
        popularity        : json['popularity'],
        id                : json['id'],
        mediaType         : typeFinal,
        name              : json['name'],
        profilePath       : json['profile_path'],
        knownForDepartment: json['known_for_department'],
        gender            : json['gender'],
        knownFor          : json['known_for'] 
      );

      }


      var listGenre = json['genre_ids'] as List;
       
      final whatTypeIs = listGenre.contains(16);

      if(whatTypeIs && type == 'tv'){
        typeFinal = 'anime';
      }else{
        typeFinal = 'tv';
      }

      if(type == 'movie'){
        typeFinal = 'movie';
      }

      
      return ResultModel(
        posterPath        : json['poster_path'],
        popularity        : json['popularity'] / 1,
        id                : json['id'],
        overview          : json['overview'],
        backdropPath      : json['backdrop_path'],
        voteAverage       : json['vote_average'] / 1,
        mediaType         : typeFinal,
        firstAirDate      : json['first_air_date'],
        genreIds          : json['genre_ids'],
        voteCount         : json['vote_count'],
        name              : json['name'],
        originalName      : json['original_name'],
        releaseDate       : json['release_date'],
        originalTitle     : json['original_title'],
        title             : json['title'],
        profilePath       : json['profile_path'],
        knownForDepartment: json['known_for_department'],
        gender            : json['gender'],
        knownFor          : json['known_for'] 
      );
  }

}