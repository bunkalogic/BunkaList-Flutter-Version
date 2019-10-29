import 'dart:convert';

import 'package:bunkalist/src/features/home_tops/data/models/series_model.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  
  final tListSeriesModel = List<SeriesModel>();

  final tSeriesModel = SeriesModel(
      posterPath       : "null",
      overview         : 'test',
      firstAirDate     : '22/11/1999',
      genreIds         : [16, 34],
      id               : 200,
      originalName     : 'original title test',
      originalLanguage : 'es',
      name             : 'title test',
      backdropPath     : 'null',
      popularity       : 2344.00,
      voteCount        : 346,
      originCountry    : ['Fr'],
      voteAverage      : 345.0,
  ); 

  test(
    'Series Model should be a sub class of SeriesEntity', 
    () async {
      //assert
      expect(tListSeriesModel, isA<List<SeriesEntity>>()); 
    }

  );

  group('Serie Model From Json', (){
      test(
        'should return a valid model when the JSON', () async {
          // arrange
          final Map<String, dynamic> jsonMap = 
          json.decode(fixture('tops_series.json'));
          // act
          final result = SeriesModel.fromJson(jsonMap);
          //assert
          expect(result, isA<SeriesEntity>());
        }
      );
    }
  );

  group('Serie Model To Json', (){
      test(
        'should return a JSON map containing the proper data', () async {
          //act
          final result = tSeriesModel.toJson();
          //assert
          final expectedJsonMap = {
            "poster_path"       : "null",
            "overview"          : 'test',
            "first_air_date"    : '22/11/1999',
            "genre_ids"         : [16, 34],
            "id"                : 200,
            "original_name"     : 'original title test',
            "original_language" : 'es',
            "name"              : 'title test',
            "backdrop_path"     : 'null',
            "popularity"        : 2344.00,
            "vote_count"        : 346,
            "origin_country"    : ['Fr'],
            "vote_average"      : 345.0,
          };
          expect(result, expectedJsonMap);
        }
      );
    }
  );

  // group('is Anime', 
  // (){
  //   test('should return type anime', (){
  //       // arrange
  //         final Map<String, dynamic> jsonMap = 
  //         json.decode(fixture('tops_anime.json'));
  //       // act
  //         final serieModel = SeriesModel.fromJson(jsonMap);
  //         final isAnime = IsAnime().isAnime(isAnime: serieModel.genreIds.contains(16));
  //         serieModel.type = isAnime;
  //       // assert  
  //         expect(serieModel.type, 'anime');
  //       }
  //     );
  //   }
  // );


}