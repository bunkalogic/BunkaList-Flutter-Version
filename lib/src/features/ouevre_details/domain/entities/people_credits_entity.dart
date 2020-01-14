import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PeopleCreditsEntity extends Equatable {
    final List<dynamic> cast;
    final List<dynamic> crew;
    final int id;

    PeopleCreditsEntity({
        @required this.cast,
        @required this.crew,
        @required this.id,
    });
}

class CastAndCrew  extends Equatable{
    final int id;
    final String character;
    final String originalTitle;
    final String overview;
    final int voteCount;
    final bool video;
    final String mediaType;
    final String releaseDate;
    final double voteAverage;
    final String title;
    final double popularity;
    final String originalLanguage;
    final List<dynamic> genreIds;
    final String backdropPath;
    final bool adult;
    final String posterPath;
    final String creditId;
    final int episodeCount;
    final List<dynamic> originCountry;
    final String originalName;
    final String name;
    final String firstAirDate;
    final String department;
    final String job;

    CastAndCrew({
        @required this.id,
        @required this.character,
        @required this.originalTitle,
        @required this.overview,
        @required this.voteCount,
        @required this.video,
        @required this.mediaType,
        @required this.releaseDate,
        @required this.voteAverage,
        @required this.title,
        @required this.popularity,
        @required this.originalLanguage,
        @required this.genreIds,
        @required this.backdropPath,
        @required this.adult,
        @required this.posterPath,
        @required this.creditId,
        @required this.episodeCount,
        @required this.originCountry,
        @required this.originalName,
        @required this.name,
        @required this.firstAirDate,
        @required this.department,
        @required this.job,
    }) : super([
        id,
        character,
        originalTitle,
        overview,
        voteCount,
        video,
        mediaType,
        releaseDate,
        voteAverage,
        title,
        popularity,
        originalLanguage,
        genreIds,
        backdropPath,
        adult,
        posterPath,
        creditId,
        episodeCount,
        originCountry,
        originalName,
        name,
        firstAirDate,
        department,
        job,
    ]);
}


