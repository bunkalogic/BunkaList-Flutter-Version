import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:meta/meta.dart';

class MovieDetailsModel extends MovieDetailsEntity {


  MovieDetailsModel({
    @required bool adult,
    @required String backdropPath,
    @required int budget,
    @required List<dynamic> genres,
    @required String homepage,
    @required int id,
    @required String imdbId,
    @required String originalLanguage,
    @required String originalTitle,
    @required String overview,
    @required double popularity,
    @required String posterPath,
    @required String releaseDate,
    @required int revenue,
    @required int runtime,
    @required String status,
    @required String tagline,
    @required String title,
    @required bool video,
    @required double voteAverage,
    @required int voteCount,
    @required List<dynamic> productionCompanies,
    @required List<dynamic> spokenLanguage,
    @required List<dynamic> productionCountry,
    String type,
  }) : super (
    adult            :  adult,  
    backdropPath     :  backdropPath,
    budget           :  budget,
    genres           :  genres,
    homepage         :  homepage,
    id               :  id,
    imdbId           :  imdbId,
    originalLanguage :  originalLanguage,
    originalTitle    :  originalTitle ,
    overview         :  overview,
    popularity       :  popularity,
    posterPath       :  posterPath,
    releaseDate      :  releaseDate ,
    revenue          :  revenue ,
    runtime          :  runtime ,
    status           :  status,
    tagline          :  tagline ,
    title            :  title ,
    video            :  video ,
    voteAverage      :  voteAverage ,
    voteCount        :  voteCount ,
    type             :  'movie'  ,
    productionCompanies: productionCompanies,
    productionCountry: productionCountry,
    spokenLanguage: spokenLanguage,
  );

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json){

    var listGenre = json['genres'] as List;
    List<GenreMovieModel> genreItems = listGenre.map((i) => GenreMovieModel.fromJson(i)).toList();

    var listProducer = json['production_companies'] as List;
    List<MovieProductionCompanyModel> producerItems = listProducer.map((i) => MovieProductionCompanyModel.fromJson(i)).toList();

    var spokenLanguage = json['spoken_languages'] as List;
    List<MovieSpokenLanguagesModel> itemSpokenLanguages = spokenLanguage.map((i) => MovieSpokenLanguagesModel.fromJson(i)).toList();

    var countryProduction = json['production_countries'] as List;
    List<MovieProductionsCountryModel> itemProductionCountry  = countryProduction.map((i) => MovieProductionsCountryModel.fromJson(i)).toList();


    return MovieDetailsModel(
      adult            :  json['adult'],  
      backdropPath     :  json['backdrop_path'],
      budget           :  json['budget'],
      genres           :  genreItems,
      homepage         :  json['homepage'],
      id               :  json['id'],
      imdbId           :  json['imdb_id'],
      originalLanguage :  json['original_language'],
      originalTitle    :  json['original_title'],
      overview         :  json['overview'],
      popularity       :  json['popularity'] / 1,
      posterPath       :  json['poster_path'],
      releaseDate      :  json['release_date'],
      revenue          :  json['revenue'],
      runtime          :  json['runtime'],
      status           :  json['status'],
      tagline          :  json['tagline'],
      title            :  json['title'],
      video            :  json['video'],
      voteAverage      :  json['vote_average'] / 1,
      voteCount        :  json['vote_count'],
      productionCompanies: producerItems,
      spokenLanguage: itemSpokenLanguages,
      productionCountry: itemProductionCountry,
      
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'adult'             :  adult,  
      'backdrop_path'     :  backdropPath,
      'budget'            :  budget,
      'genres'            :  genres,
      'homepage'          :  homepage,
      'id'                :  id,
      'imdb_id'           :  imdbId,
      'original_language' :  originalLanguage,
      'original_title'    :  originalTitle ,
      'overview'          :  overview,
      'popularity'        :  popularity,
      'poster_path'       :  posterPath,
      'release_date'      :  releaseDate ,
      'revenue'           :  revenue ,
      'runtime'           :  runtime ,
      'status'            :  status,
      'tagline'           :  tagline ,
      'title'             :  title ,
      'video'             :  video ,
      'vote_average'      :  voteAverage ,
      'vote_count'        :  voteCount ,
      'production_companies': productionCompanies,
      'spoken_languages' : spokenLanguage,
      'production_countries' : productionCountry,
    };
  }


}

class GenreMovieModel extends GenreMovie{
  GenreMovieModel({
    @required int id,
    @required String name,
  }) : super (
      id           :id ,
      name         :name , 
  );

  factory GenreMovieModel.fromJson(Map<String, dynamic> json){
     return GenreMovieModel(
          id           :json['id'] ,
          name         :json['name'] , 
     );

  }

   Map<String, dynamic> toJson(){
     return{
      'id'            : id,
      'name'          : name,
     };
   }
}


class MovieProductionCompanyModel  extends MovieProductionCompany{
    MovieProductionCompanyModel({
        @required this.id,
        @required this.logoPath,
        @required this.name,
        @required this.originCountry,
    });

    final int id;
    final String logoPath;
    final String name;
    final String originCountry;

    

    factory MovieProductionCompanyModel.fromJson(Map<String, dynamic> json) => MovieProductionCompanyModel(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
    };
}


class MovieProductionsCountryModel extends MovieProductionCountry{
    MovieProductionsCountryModel({
        @required this.iso31661,
        @required this.name,
    });

    final String iso31661;
    final String name;


    factory MovieProductionsCountryModel.fromJson(Map<String, dynamic> json) => MovieProductionsCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}


class MovieSpokenLanguagesModel  extends MovieSpokenLanguage{
    MovieSpokenLanguagesModel({
        @required this.englishName,
        @required this.iso6391,
        @required this.name,
    });

    final String englishName;
    final String iso6391;
    final String name;

    

    factory MovieSpokenLanguagesModel.fromJson(Map<String, dynamic> json) => MovieSpokenLanguagesModel(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
    };
}
