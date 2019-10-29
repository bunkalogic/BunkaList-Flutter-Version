import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';

class AnimeModel  extends AnimeEntity{

    AnimeModel({
        final String posterPath,
        final double popularity,
        final int id,
        final dynamic backdropPath,
        final double voteAverage,
        final String overview,
        final String firstAirDate,
        final List<String> originCountry,
        final List<int> genreIds,
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
      type             : 'anime'
    );

    factory AnimeModel.fromJson(Map<String, dynamic> json){
      return AnimeModel(
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

class Animes{
  List<AnimeModel> items = new List();

  Animes();

  Animes.fromJsonList(List<dynamic> jsonList){
    
    if (jsonList == null) return;

    for(var item in jsonList){
      final anime = new AnimeModel.fromJson(item);

      items.add(anime);
    }
  }
}