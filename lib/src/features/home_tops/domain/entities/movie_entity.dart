import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MovieEntity  extends Equatable{
  
    final dynamic posterPath;
    final bool adult;
    final String overview;
    final String releaseDate;
    final List<int> genreIds;
    final int id;
    final String originalTitle;
    final String originalLanguage;
    final String title;
    final dynamic backdropPath;
    final double popularity;
    final int voteCount;
    final bool video;
    final double voteAverage;
    final String type;

    MovieEntity({
        @required this.posterPath,
        @required this.adult,
        @required this.overview,
        @required this.releaseDate,
        @required this.genreIds,
        @required this.id,
        @required this.originalTitle,
        @required this.originalLanguage,
        @required this.title,
        @required this.backdropPath,
        @required this.popularity,
        @required this.voteCount,
        @required this.video,
        @required this.voteAverage,
        @required this.type
    }) : super([
      posterPath,
      adult,
      overview,
      releaseDate,
      genreIds,
      id,
      originalTitle,
      originalLanguage,
      title,
      backdropPath,
      popularity,
      voteCount,
      video,
      voteAverage,
      type
    ]);
}