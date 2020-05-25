import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SeriesEntity extends Equatable {
    
    final String posterPath;
    final double popularity;
    final int id;
    final dynamic backdropPath;
    final double voteAverage;
    final String overview;
    final String firstAirDate;
    final List<dynamic> originCountry;
    final List<dynamic> genreIds;
    final String originalLanguage;
    final int voteCount;
    final String name;
    final String originalName;
    final String type;

    SeriesEntity({
        @required this.posterPath,
        @required this.popularity,
        @required this.id,
        @required this.backdropPath,
        @required this.voteAverage,
        @required this.overview,
        @required this.firstAirDate,
        @required this.originCountry,
        @required this.genreIds,
        @required this.originalLanguage,
        @required this.voteCount,
        @required this.name,
        @required this.originalName,
        @required this.type
    }) : super([
      posterPath,
      popularity,
      id,
      backdropPath,
      voteAverage,
      overview,
      firstAirDate,
      originCountry.cast<String>(),
      genreIds.cast<int>(),
      originalLanguage,
      voteCount,
      name,
      originalName,
      type
    ]);
}
