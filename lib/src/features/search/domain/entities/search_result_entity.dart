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
    final String releaseDate;
    final String originalTitle;
    final String title;
    final String profilePath;
    final String knownForDepartment;
    final int gender;
    final List<dynamic> knownFor;
    

    Result({
        this.posterPath,
        this.popularity,
        this.id,
        this.overview,
        this.backdropPath,
        this.voteAverage,
        this.mediaType,
        this.firstAirDate,
        this.genreIds,
        this.voteCount,
        this.name,
        this.originalName,
        this.releaseDate,
        this.originalTitle,
        this.title,
        this.profilePath,
        this.knownForDepartment,
        this.gender,
        this.knownFor
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
      knownForDepartment,
      gender,
      knownFor
    ]);
}