import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


class SerieDetailsEntity extends Equatable{
    final String backdropPath;
    final List<dynamic> episodeRunTime;
    final String firstAirDate;
    final List<dynamic> genres;
    final String homepage;
    final int id;
    final bool inProduction;
    final List<dynamic> languages;
    final String lastAirDate;
    final String name;
    final List<dynamic> networks;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final List<dynamic> originCountry;
    final String originalLanguage;
    final String originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final String status;
    final double voteAverage;
    final int voteCount;
    final String type;

    SerieDetailsEntity({
        @required this.backdropPath,
        @required this.episodeRunTime,
        @required this.firstAirDate,
        @required this.genres,
        @required this.homepage,
        @required this.id,
        @required this.inProduction,
        @required this.languages,
        @required this.lastAirDate,
        @required this.name,
        @required this.networks,
        @required this.numberOfEpisodes,
        @required this.numberOfSeasons,
        @required this.originCountry,
        @required this.originalLanguage,
        @required this.originalName,
        @required this.overview,
        @required this.popularity,
        @required this.posterPath,
        @required this.status,
        @required this.voteAverage,
        @required this.voteCount,
        @required this.type,
    }) : super([
      backdropPath,
      episodeRunTime.cast<int>(),
      firstAirDate,
      genres.cast<int>(),
      homepage,
      id,
      inProduction,
      languages.cast<String>(),
      lastAirDate,
      name,
      networks.cast<Network>(),
      numberOfEpisodes,
      numberOfSeasons,
      originCountry.cast<String>(),
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      status,
      voteAverage,
      voteCount,
      type,
    ]);
}


class Network extends Equatable {
    final String name;
    final int id;
    final String logoPath;
    final String originCountry;

    Network({
        @required this.name,
        @required this.id,
        @required this.logoPath,
        @required this.originCountry,
    }) : super([
      name,
      id,
      logoPath,
      originCountry,
    ]);
}