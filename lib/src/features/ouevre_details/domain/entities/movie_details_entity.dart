import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


class MovieDetailsEntity extends Equatable {
    final bool adult;
    final String backdropPath;
    final int budget;
    final List<dynamic> genres;
    final String homepage;
    final int id;
    final String imdbId;
    final String originalLanguage;
    final String originalTitle;
    final String overview;
    final double popularity;
    final String posterPath;
    final String releaseDate;
    final int revenue;
    final int runtime;
    final String status;
    final String tagline;
    final String title;
    final bool video;
    final double voteAverage;
    final int voteCount;
    final String type;


    MovieDetailsEntity({
        @required this.adult,
        @required this.backdropPath,
        @required this.budget,
        @required this.genres,
        @required this.homepage,
        @required this.id,
        @required this.imdbId,
        @required this.originalLanguage,
        @required this.originalTitle,
        @required this.overview,
        @required this.popularity,
        @required this.posterPath,
        @required this.releaseDate,
        @required this.revenue,
        @required this.runtime,
        @required this.status,
        @required this.tagline,
        @required this.title,
        @required this.video,
        @required this.voteAverage,
        @required this.voteCount,
        @required this.type
    }) : super([
      adult,
      backdropPath,
      budget,
      genres,
      homepage,
      id,
      imdbId,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      revenue,
      runtime,
      status,
      tagline,
      title,
      video,
      voteAverage,
      voteCount,
      type  
    ]);
}

class GenreMovie extends Equatable {
    final int id;
    final String name;
    

    GenreMovie({
        @required this.id,
        @required this.name,
        
    }) : super([
      id, 
      name,
    ]);
}