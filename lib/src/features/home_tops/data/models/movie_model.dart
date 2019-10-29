import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:meta/meta.dart';

class MovieModel  extends MovieEntity{

    MovieModel({
        @required dynamic posterPath,
        @required bool adult,
        @required String overview,
        @required String releaseDate,
        @required List<int> genreIds,
        @required int id,
        @required String originalTitle,
        @required String originalLanguage,
        @required String title,
        @required dynamic backdropPath,
        @required double popularity,
        @required int voteCount,
        @required bool video,
        @required double voteAverage,
        String type,
    }) : super(
      posterPath       : posterPath,
      adult            : adult,
      overview         : overview,
      releaseDate      : releaseDate,
      genreIds         : genreIds,
      id               : id,
      originalTitle    : originalTitle,
      originalLanguage : originalLanguage,
      title            : title,
      backdropPath     : backdropPath,
      popularity       : popularity,
      voteCount        : voteCount,
      video            : video,
      voteAverage      : voteAverage,
      type             : 'movie'
    );

    factory MovieModel.fromJson(Map<String, dynamic> json){
      return MovieModel(
        posterPath       : json['posterPath'],
        adult            : json['adult'],
        overview         : json['overview'],
        releaseDate      : json['releaseDate'],
        genreIds         : json['genreIds'],
        id               : json['id'],
        originalTitle    : json['originalTitle'],
        originalLanguage : json['originalLanguage'],
        title            : json['title'],
        backdropPath     : json['backdropPath'],
        popularity       : json['popularity'],
        voteCount        : json['voteCount'],
        video            : json['video'],
        voteAverage      : json['voteAverage'],
      );
    }

    Map<String, dynamic> toJson(){
      return{
        'poster_path'       : posterPath,
        'adult'             : adult,
        'overview'          : overview,
        'release_date'      : releaseDate,
        'genre_ids'         : genreIds,
        'id'                : id,
        'original_title'    : originalTitle,
        'original_language' : originalLanguage,
        'title'             : title,
        'backdrop_path'     : backdropPath,
        'popularity'        : popularity,
        'vote_count'        : voteCount,
        'video'             : video,
        'vote_average'      : voteAverage,
      };
    }
}

class Movies{
  List<MovieModel> items = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList){
    
    if (jsonList == null) return;

    for(var item in jsonList){
      final movie = new MovieModel.fromJson(item);

      items.add(movie);
    }
  }
}