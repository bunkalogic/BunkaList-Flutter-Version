import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_rs_entity.dart';
import 'package:meta/meta.dart';

class SeriesModelRS  extends SeriesEntityRS{
 

    SeriesModelRS({
        @required String posterPath,
        @required double popularity,
        @required int id,
        @required dynamic backdropPath,
        @required double voteAverage,
        @required String overview,
        @required String firstAirDate,
        @required List<dynamic> originCountry,
        @required List<dynamic> genreIds,
        @required String originalLanguage,
        @required int voteCount,
        @required String name,
        @required String originalName,
        String type
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
      type             : ''
    );

    factory SeriesModelRS.fromJson(Map<String, dynamic> json){

      var listGenre = json['genre_ids'] as List<int>;
      String typeFinal; 

       // Se encarga de comprobar en la lista de genres si hay un 16 para saber si es un anime o no  
       listGenre.forEach((genre){

         if(genre == 16){
           typeFinal = 'anime';
         }else{
           typeFinal = 'tv';
         }

       });


      return SeriesModelRS(
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
        'original_name'     : originalName,
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

class Series{
  List<SeriesModelRS> items = new List();

  Series();

  Series.fromJsonList(List<dynamic> jsonList){
    
    if (jsonList == null) return;

    for(var item in jsonList){
      final serie = new SeriesModelRS.fromJson(item);

      items.add(serie);
    }
  }
}