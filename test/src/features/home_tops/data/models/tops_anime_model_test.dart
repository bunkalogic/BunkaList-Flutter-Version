import 'dart:convert';

import 'package:bunkalist/src/features/home_tops/data/models/anime_model.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  
  final tListAnimeModel = List<AnimeModel>();

  final tAnimeModel = AnimeModel(
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
    'Anime Model should be a sub class of AnimeEntity', 
    () async {
      //assert
      expect(tListAnimeModel, isA<List<AnimeEntity>>()); 
    }

  );

  group('Anime Model From Json', (){
      test(
        'should return a valid model when the JSON', () async {
          // arrange
          final Map<String, dynamic> jsonMap = 
          json.decode(fixture('tops_anime.json'));
          // act
          final result = AnimeModel.fromJson(jsonMap);
          //assert
          expect(result, isA<AnimeEntity>());
        }
      );
    }
  );

  group('Anime Model To Json', (){
      test(
        'should return a JSON map containing the proper data', () async {
          //act
          final result = tAnimeModel.toJson();
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
  //         final serieModel = AnimeModel.fromJson(jsonMap);
  //         final isAnime = IsAnime().isAnime(isAnime: serieModel.genreIds.contains(16));
  //         serieModel.type = isAnime;
  //       // assert  
  //         expect(serieModel.type, 'anime');
  //       }
  //     );
  //   }
  // );


}