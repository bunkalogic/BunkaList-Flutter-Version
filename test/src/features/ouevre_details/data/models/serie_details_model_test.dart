import 'dart:convert';

import 'package:bunkalist/src/features/ouevre_details/data/models/serie_details_model.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

main(){


  final tSerieDetailsModel = SerieDetailsModel(
      backdropPath:  '/null',
      episodeRunTime: [16, 18] ,
      firstAirDate: '2/10/2010' ,
      genres: List<GenreSerieModel>(),
      homepage: 'null',
      id: 3245,
      inProduction: false,
      languages: ['ja', 'en'],
      lastAirDate: '2/10/2010' ,
      name: 'Name',
      networks: List<NetworkSerieModel>(),
      numberOfEpisodes: 40,
      numberOfSeasons: 3,
      originCountry: ['ja'],
      originalLanguage: 'ja',
      originalName: 'Original Name',
      overview: 'lorem inpsum',
      popularity: 3290.90,
      posterPath: '/null',
      status: 'finish',
      voteAverage: 8.5,
      voteCount: 34,
      seasonSerie: List<SeasonSerieModel>()
    );


    test('SerieDetailsModel should be a sub class of SerieDetailsEntity', () async {

      //assert
      expect(tSerieDetailsModel, isA<SerieDetailsEntity>());



    });

    group('SerieDetailsModel from Json', (){

      test('should return a valid model when the JSON', () async {

        //arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('serie_details.json'));
        //act
        final result = SerieDetailsModel.fromJson(jsonMap);
        //assert
        expect(result, isA<SerieDetailsEntity>());
      });
    });

    group('SerieDetailsModel to Json', (){

      test('should return a Json map containing the proper data', () async {

        //act
        final result = tSerieDetailsModel.toJson();
        //assert
        final expectedJsonMap = {
          "backdrop_path"      :  '/null',
          "episode_run_time"   : [16, 18] ,
          "first_air_date"     : '2/10/2010' ,
          "genres"             : List<GenreSerieModel>(),
          "homepage"           : 'null',
          "id"                 : 3245,
          "in_production"      : false,
          "languages"          : ['ja', 'en'],
          "last_air_date"      : '2/10/2010' ,
          "name"               : 'Name',
          "networks"           : List<NetworkSerieModel>(),
          "number_of_episodes" : 40,
          "number_of_seasons"  : 3,
          "origin_country"     : ['ja'],
          "original_language"  : 'ja',
          "original_name"      : 'Original Name',
          "overview"           : 'lorem inpsum',
          "popularity"         : 3290.90,
          "poster_path"        : '/null',
          "status"             : 'finish',
          "vote_average"       : 8.5,
          "vote_count"         : 34,
          "seasons"            : List<SeasonSerieModel>(),
        };


        expect(result, expectedJsonMap);




      });
    });


}