import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SeasonEntity extends Equatable{
    SeasonEntity({
        @required this.id,
        @required this.airDate,
        @required this.episodes,
        @required this.name,
        @required this.overview,
        @required this.seasonEntityId,
        @required this.posterPath,
        @required this.seasonNumber,
    }) : super([
      id,
      airDate,
      episodes,
      name,
      overview,
      seasonEntityId,
      posterPath,
      seasonNumber,
    ]);

    final String id;
    final String airDate;
    final List<Episode> episodes;
    final String name;
    final String overview;
    final int seasonEntityId;
    final String posterPath;
    final int seasonNumber;
}

class Episode extends Equatable{
    Episode({
        @required this.airDate,
        @required this.episodeNumber,
        @required this.crew,
        @required this.guestStars,
        @required this.id,
        @required this.name,
        @required this.overview,
        @required this.productionCode,
        @required this.seasonNumber,
        @required this.stillPath,
        @required this.voteAverage,
        @required this.voteCount,
    }) : super([
      airDate,
      episodeNumber,
      crew,
      guestStars,
      id,
      name,
      overview,
      productionCode,
      seasonNumber,
      stillPath,
      voteAverage,
      voteCount,
    ]);

    final String airDate;
    final int episodeNumber;
    final List<Crew> crew;
    final List<Crew> guestStars;
    final int id;
    final String name;
    final String overview;
    final String productionCode;
    final int seasonNumber;
    final String stillPath;
    final double voteAverage;
    final int voteCount;
}

class Crew extends Equatable{
    Crew({
        @required this.job,
        @required this.department,
        @required this.creditId,
        @required this.adult,
        @required this.gender,
        @required this.id,
        @required this.knownForDepartment,
        @required this.name,
        @required this.originalName,
        @required this.popularity,
        @required this.profilePath,
        @required this.character,
        @required this.order,
    }) : super([
      job,
      department,
      creditId,
      adult,
      gender,
      id,
      knownForDepartment,
      name,
      originalName,
      popularity,
      profilePath,
      character,
      order,
    ]);

    final String job;
    final String department;
    final String creditId;
    final bool adult;
    final int gender;
    final int id;
    final String knownForDepartment;
    final String name;
    final String originalName;
    final double popularity;
    final String profilePath;
    final String character;
    final int order;
}


