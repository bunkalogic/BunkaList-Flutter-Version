
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';


class SeasonModel extends SeasonEntity {
    SeasonModel({
        @required this.id,
        @required this.airDate,
        @required this.episodes,
        @required this.name,
        @required this.overview,
        @required this.seasonModelId,
        @required this.posterPath,
        @required this.seasonNumber,
    });

    final String id;
    final String airDate;
    final List<EpisodeModel> episodes;
    final String name;
    final String overview;
    final int seasonModelId;
    final String posterPath;
    final int seasonNumber;

    factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["_id"],
        airDate: json["air_date"],
        episodes: List<EpisodeModel>.from(json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonModelId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": seasonModelId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
    };
}

class EpisodeModel extends Episode{
    EpisodeModel({
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
    });

    final String airDate;
    final int episodeNumber;
    final List<CrewModel> crew;
    final List<CrewModel> guestStars;
    final int id;
    final String name;
    final String overview;
    final String productionCode;
    final int seasonNumber;
    final String stillPath;
    final double voteAverage;
    final int voteCount;

    factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        crew: List<CrewModel>.from(json["crew"].map((x) => CrewModel.fromJson(x))),
        guestStars: List<CrewModel>.from(json["guest_stars"].map((x) => CrewModel.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "guest_stars": List<dynamic>.from(guestStars.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

class CrewModel extends Crew {
    CrewModel({
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
    });

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

    factory CrewModel.fromJson(Map<String, dynamic> json) => CrewModel(
        job: json["job"],
        department: json["department"],
        creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        character: json["character"],
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "job": job,
        "department": department,
        "credit_id": creditId,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "character": character,
        "order": order,
    };
}