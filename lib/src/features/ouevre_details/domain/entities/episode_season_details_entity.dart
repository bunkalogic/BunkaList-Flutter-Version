import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class EpisodeEntity  extends Equatable {
    final String airDate;
    final int episodeNumber;
    final int id;
    final String name;
    final String overview;
    final String productionCode;
    final int seasonNumber;
    final int showId;
    final String stillPath;
    final double voteAverage;
    final int voteCount;


    EpisodeEntity({
        @required this.airDate,
        @required this.episodeNumber,
        @required this.id,
        @required this.name,
        @required this.overview,
        @required this.productionCode,
        @required this.seasonNumber,
        @required this.showId,
        @required this.stillPath,
        @required this.voteAverage,
        @required this.voteCount,
    }) : super([
      airDate,
      episodeNumber,
      id,
      name,
      overview,
      productionCode,
      seasonNumber,
      showId,
      stillPath,
      voteAverage,
      voteCount,
    ]);
}