

import 'dart:convert';

import 'package:bunkalist/src/features/ouevre_details/data/models/movie_details_model.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

main(){


  final tMovieDetailsModel = MovieDetailsModel(
      adult: false ,
      backdropPath: '/null',
      budget:  20,
      genres: [18, 34],
      homepage: 'null',
      id: 25467,
      imdbId: '32455',
      originalLanguage: 'en',
      originalTitle: 'Original Title',
      overview: 'lorem impsum',
      popularity: 328943.30,
      posterPath: '/null',
      releaseDate: '20/12/14',
      revenue: 3230943,
      runtime: 32 ,
      status: 'finish' ,
      tagline: 'tag'  ,
      title: 'title' ,
      video: false ,
      voteAverage: 7.55 ,
      voteCount: 439839 ,
    );

    test('MovieDetailsModel should be a sub class of MovieDetailsEntity', () async {

      //assert
      expect(tMovieDetailsModel, isA<MovieDetailsEntity>());



    });

    group('MovieDetailsModel from Json', (){

      test('should return a valid model when the JSON', () async {

        //arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('movie_details.json'));
        //act
        final result = MovieDetailsModel.fromJson(jsonMap);
        //assert
        expect(result, isA<MovieDetailsEntity>());
      });
    });

    group('MovieDetailsModel to Json', (){

      test('should return a Json map containing the proper data', () async {

        //act
        final result = tMovieDetailsModel.toJson();
        //assert
        final expectedJsonMap = {
          "adult"  : false ,
          "backdrop_path"  : '/null',
          "budget"  :  20,
          "genres"  : [18, 34],
          "homepage"  : 'null',
          "id"  : 25467,
          "imdb_id"  : '32455',
          "original_language"  : 'en',
          "original_title"  : 'Original Title',
          "overview"  : 'lorem impsum',
          "popularity"  : 328943.30,
          "poster_path"  : '/null',
          "release_date"  : '20/12/14',
          "revenue"  : 3230943,
          "runtime"  : 32 ,
          "status"  : 'finish' ,
          "tagline"  : 'tag'  ,
          "title"  : 'title' ,
          "video"  : false ,
          "vote_average"  : 7.55 ,
          "vote_count"  : 439839 ,
        };


        expect(result, expectedJsonMap);




      });
    });


}