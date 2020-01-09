import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_rs_entity.dart';

class AnimeModelRS  extends AnimeEntityRS{
      
    AnimeModelRS({
        final String posterPath,
        final double popularity,
        final int id,
        final dynamic backdropPath,
        final double voteAverage,
        final String overview,
        final String firstAirDate,
        final List<dynamic> originCountry,
        final List<dynamic> genreIds,
        final String originalLanguage,
        final int voteCount,
        final String name,
        final String originalName,
        String type,
    }) : super(
      posterPath       : posterPath,
      overview         : overview,
      firstAirDate     : firstAirDate,
      genreIds         : genreIds,
      id               : id,
      originalName     : originalName,
      originalLanguage : originalLanguage,
      name             : name,
      backdropPath     : backdropPath,
      popularity       : popularity,
      voteCount        : voteCount,
      originCountry    : originCountry,
      voteAverage      : voteAverage,
      type             : type
    );

    factory AnimeModelRS.fromJson(Map<String, dynamic> json){

      var listGenre = json['genre_ids'] as List;
      String typeFinal; 

      final whatTypeIs = listGenre.contains(16);

      (whatTypeIs) ?  typeFinal = 'anime' : typeFinal = 'tv';
       
      print('is type: ' + typeFinal);

      return AnimeModelRS(
        posterPath       : json['poster_path'],
        overview         : json['overview'],
        firstAirDate     : json['first_air_date'],
        genreIds         : json['genre_ids'],
        id               : json['id'],
        originalName     : json['original_name'],
        originalLanguage : json['original_language'],
        name             : json['name'],
        backdropPath     : json['backdrop_path'],
        popularity       : json['popularity'] / 1,
        voteCount        : json['vote_count'],
        originCountry    : json['origin_country'],
        voteAverage      : json['vote_average'] / 1,
        type             : typeFinal 
      );
    }

    Map<String, dynamic> toJson(){
      return{
        'poster_path'       : posterPath,
        'overview'          : overview,
        'first_air_date'    : firstAirDate,
        'genre_ids'         : genreIds,
        'id'                : id,
        'original_name'    : originalName,
        'original_language' : originalLanguage,
        'name'              : name,
        'backdrop_path'     : backdropPath,
        'popularity'        : popularity,
        'vote_count'        : voteCount,
        'origin_country'    : originCountry,
        'vote_average'      : voteAverage,
      };
    }

    
}

class Animes{
  List<AnimeModelRS> items = new List();

  Animes();

  Animes.fromJsonList(List<dynamic> jsonList){
    
    if (jsonList == null) return;

    for(var item in jsonList){
      final anime = new AnimeModelRS.fromJson(item);

      items.add(anime);
    }
  }
}