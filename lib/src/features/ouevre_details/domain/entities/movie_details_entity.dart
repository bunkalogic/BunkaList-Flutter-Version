import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


class MovieDetailsEntity extends Equatable {
    final bool adult;
    final String backdropPath;
    final int budget;
    final List<dynamic> genres;
    final String homepage;
    final int id;
    final String imdbId;
    final String originalLanguage;
    final String originalTitle;
    final String overview;
    final double popularity;
    final String posterPath;
    final String releaseDate;
    final int revenue;
    final int runtime;
    final String status;
    final String tagline;
    final String title;
    final bool video;
    final double voteAverage;
    final int voteCount;
    final String type;
    final List<dynamic> productionCompanies;
    final List<dynamic> productionCountry;
    final List<dynamic> spokenLanguage;


    MovieDetailsEntity({
        @required this.adult,
        @required this.backdropPath,
        @required this.budget,
        @required this.genres,
        @required this.homepage,
        @required this.id,
        @required this.imdbId,
        @required this.originalLanguage,
        @required this.originalTitle,
        @required this.overview,
        @required this.popularity,
        @required this.posterPath,
        @required this.releaseDate,
        @required this.revenue,
        @required this.runtime,
        @required this.status,
        @required this.tagline,
        @required this.title,
        @required this.video,
        @required this.voteAverage,
        @required this.voteCount,
        @required this.productionCompanies,
        @required this.productionCountry,
        @required this.spokenLanguage,
        @required this.type
    }) : super([
      adult,
      backdropPath,
      budget,
      genres,
      homepage,
      id,
      imdbId,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      revenue,
      runtime,
      status,
      tagline,
      title,
      video,
      voteAverage,
      voteCount,
      productionCompanies,
      productionCountry,
      spokenLanguage,
      type  
    ]);
}

class GenreMovie extends Equatable {
    final int id;
    final String name;
    

    GenreMovie({
        @required this.id,
        @required this.name,
        
    }) : super([
      id, 
      name,
    ]);
}


class MovieProductionCompany  extends Equatable{
    
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;
  
  
  MovieProductionCompany({
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

class MovieProductionCountry  extends Equatable{
    
    final String iso31661;
    final String name;
    
    
    MovieProductionCountry({
        @required this.iso31661,
        @required this.name,
    }) : super([
      iso31661,
      name,
    ]);

    
}


class MovieSpokenLanguage extends Equatable {
    
    final String englishName;
    final String iso6391;
    final String name;
    
    MovieSpokenLanguage({
        @required this.englishName,
        @required this.iso6391,
        @required this.name,
    }) : super([
      englishName,
      iso6391,
      name,
    ]);

    
}