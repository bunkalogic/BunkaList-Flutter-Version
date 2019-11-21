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
  );

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json){
    return MovieDetailsModel(
      adult            :  json['adult'],  
      backdropPath     :  json['backdrop_path'],
      budget           :  json['budget'],
      genres           :  json['genres'],
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
    };
  }


}