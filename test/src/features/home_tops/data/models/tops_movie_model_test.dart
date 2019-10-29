import 'dart:convert';

import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  
  final tListMovieModel = List<MovieModel>();

  final tMovieModel = MovieModel(
      posterPath       : "null",
      adult            : false,
      overview         : 'test',
      releaseDate      : '22/11/1999',
      genreIds         : [16, 34],
      id               : 200,
      originalTitle    : 'original title test',
      originalLanguage : 'es',
      title            : 'title test',
      backdropPath     : 'null',
      popularity       : 2344.00,
      voteCount        : 346,
      video            : true,
      voteAverage      : 345.0,
  ); 

  test(
    'Movie Model should be a sub class of MovieEntity', 
    () async {
      //assert
      expect(tListMovieModel, isA<List<MovieEntity>>()); 
    }

  );

  group('Movie Model From Json', (){
      test(
        'should return a valid model when the JSON', () async {
          // arrange
          final Map<String, dynamic> jsonMap = 
          json.decode(fixture('tops_movies.json'));
          // act
          final result = MovieModel.fromJson(jsonMap);
          //assert
          expect(result, isA<MovieEntity>());
        }
      );
    }
  );

  group('Movie Model To Json', (){
      test(
        'should return a JSON map containing the proper data', () async {
          //act
          final result = tMovieModel.toJson();
          //assert
          final expectedJsonMap = {
            "poster_path"      : "null",
            "adult"            : false,
            "overview"         : 'test',
            "release_date"     : '22/11/1999',
            "genre_ids"        : [16, 34],
            "id"               : 200,
            "original_title"   : 'original title test',
            "original_language": 'es',
            "title"            : 'title test',
            "backdrop_path"    : 'null',
            "popularity"       : 2344.00,
            "vote_count"       : 346,
            "video"            : true,
            "vote_average"     : 345.0,
          };
          expect(result, expectedJsonMap);
        }
      );
    }
  );


}