import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


class AnimeDetailsEntity extends Equatable{
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
    final List<dynamic> seasonAnime;
    final List<dynamic> productionCompanies;
    final dynamic lastEpisodeToAir;
    final dynamic nextEpisodeToAir;
    final List<dynamic> productionCountry;
    final List<dynamic> spokenLanguage;
    final List<dynamic> createdBy;


    AnimeDetailsEntity({
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
        @required this.seasonAnime,
        @required this.productionCompanies,
        @required this.lastEpisodeToAir,
        @required this.nextEpisodeToAir,
        @required this.productionCountry,
        @required this.spokenLanguage,
        @required this.createdBy
    }) : super([
      backdropPath,
      episodeRunTime.cast<int>(),
      firstAirDate,
      genres,
      homepage,
      id,
      inProduction,
      languages.cast<String>(),
      lastAirDate,
      name,
      networks,
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
      seasonAnime,
      productionCompanies, 
      lastEpisodeToAir,
      nextEpisodeToAir, 
      productionCountry,
      spokenLanguage, 
      createdBy
    ]);
}


class NetworkAnime extends Equatable {
    final String name;
    final int id;
    final String logoPath;
    final String originCountry;

    NetworkAnime({
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

class GenreAnime extends Equatable {
    final int id;
    final String name;
    

    GenreAnime({
        @required this.id,
        @required this.name,
        
    }) : super([
      id, 
      name,
    ]);
}

class SeasonAnime extends Equatable {
    final String airDate;
    final int episodeCount;
    final int id;
    final String name;
    final String overview;
    final String posterPath;
    final int seasonNumber;

    SeasonAnime({
        @required this.airDate,
        @required this.episodeCount,
        @required this.id,
        @required this.name,
        @required this.overview,
        @required this.posterPath,
        @required this.seasonNumber,
    }) : super([
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
    ]);
}

class AnimeProductionCompany  extends Equatable{
    
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;
  
  
  AnimeProductionCompany({
      @required this.id,
      @required this.logoPath,
      @required this.name,
      @required this.originCountry,
  }) : super([
    id,
    logoPath,
    name,
    originCountry,
  ]);

    
}



class AnimeLastEpisodeToAir extends Equatable {
    
    final String airDate;
    final int episodeNumber;
    final int id;
    final String name;
    final String overview;
    final String productionCode;
    final int seasonNumber;
    final String stillPath;
    final double voteAverage;
    final int voteCount;
    
    
    
    
    AnimeLastEpisodeToAir({
        @required this.airDate,
        @required this.episodeNumber,
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
      id,
      name,
      overview,
      productionCode,
      seasonNumber,
      stillPath,
      voteAverage,
      voteCount,
    ]);

    
}


class AnimeProductionCountry  extends Equatable{
    
    final String iso31661;
    final String name;
    
    
    AnimeProductionCountry({
        @required this.iso31661,
        @required this.name,
    }) : super([
      iso31661,
      name,
    ]);

    
}


class AnimeSpokenLanguage extends Equatable {
    
    final String englishName;
    final String iso6391;
    final String name;
    
    AnimeSpokenLanguage({
        @required this.englishName,
        @required this.iso6391,
        @required this.name,
    }) : super([
      englishName,
      iso6391,
      name,
    ]);

    
}

class AnimeCreatedBy  extends Equatable {
    
    final int id;
    final String creditId;
    final String name;
    final int gender;
    final String profilePath;
    
    
    AnimeCreatedBy({
        @required this.id,
        @required this.creditId,
        @required this.name,
        @required this.gender,
        @required this.profilePath,
    }): super([
      id,
      creditId,
      name,
      gender,
      profilePath,
    ]);

    
}

