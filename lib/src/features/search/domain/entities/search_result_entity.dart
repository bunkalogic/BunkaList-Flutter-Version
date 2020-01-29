import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ResultsEntity extends Equatable {
    final int page;
    final List<dynamic> results;
    final int totalResults;
    final int totalPages;

    ResultsEntity({
        @required this.page,
        @required this.results,
        @required this.totalResults,
        @required this.totalPages,
    });
}

class Result extends Equatable {
    final String posterPath;
    final double popularity;
    final int id;
    final String overview;
    final String backdropPath;
    final double voteAverage;
    final String mediaType;
    final String firstAirDate;
    final List<dynamic> genreIds;
    final int voteCount;
    final String name;
    final String originalName;
    final DateTime releaseDate;
    final String originalTitle;
    final String title;
    final String profilePath;
    

    Result({
        @required this.posterPath,
        @required this.popularity,
        @required this.id,
        @required this.overview,
        @required this.backdropPath,
        @required this.voteAverage,
        @required this.mediaType,
        @required this.firstAirDate,
        @required this.genreIds,
        @required this.voteCount,
        @required this.name,
        @required this.originalName,
        @required this.releaseDate,
        @required this.originalTitle,
        @required this.title,
        @required this.profilePath,
    }) : super ([
      posterPath,
      popularity,
      id,
      overview,
      backdropPath,
      voteAverage,
      mediaType,
      firstAirDate,
      genreIds,
      voteCount,
      name,
      originalName,
      releaseDate,
      originalTitle,
      title,
      profilePath,
    ]);
}