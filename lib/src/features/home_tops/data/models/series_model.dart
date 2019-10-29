import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';

class SeriesModel  extends SeriesEntity{
 

    SeriesModel({
        @required String posterPath,
        @required double popularity,
        @required int id,
        @required dynamic backdropPath,
        @required double voteAverage,
        @required String overview,
        @required String firstAirDate,
        @required List<String> originCountry,
        @required List<int> genreIds,
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
      type             : 'tv'
    );

    factory SeriesModel.fromJson(Map<String, dynamic> json){
      return SeriesModel(
        posterPath       : json['posterPath'],
        overview         : json['overview'],
        firstAirDate     : json['firstAirDate'],
        genreIds         : json['genreIds'],
        id               : json['id'],
        originalName     : json['originalName'],
        originalLanguage : json['originalLanguage'],
        name             : json['name'],
        backdropPath     : json['backdropPath'],
        popularity       : json['popularity'],
        voteCount        : json['voteCount'],
        originCountry    : json['originCountry'],
        voteAverage      : json['voteAverage'],
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

class Series{
  List<SeriesModel> items = new List();

  Series();

  Series.fromJsonList(List<dynamic> jsonList){
    
    if (jsonList == null) return;

    for(var item in jsonList){
      final serie = new SeriesModel.fromJson(item);

      items.add(serie);
    }
  }
}