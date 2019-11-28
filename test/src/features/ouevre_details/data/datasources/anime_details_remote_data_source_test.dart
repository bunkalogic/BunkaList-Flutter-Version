



import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/anime_details_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http ;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  
  AnimeDetailsRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp((){

    mockHttpClient = MockHttpClient();
    dataSourceImpl = AnimeDetailsRemoteDataSourceImpl(client: mockHttpClient);

  });

  group('get All Details Anime', (){

    void setUpMockHttpClientSuccess200(){

      when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('anime_details.json'), 200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        }
        ));

    }

    void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
    }

  group('Get All Details Anime Response', () {

    final String url = 'https://api.themoviedb.org/3/tv/1095?api_key=7bcf40aff5d7be80e294d763234a6930&language=en-US';

    final tdecodedData = json.decode(fixture('anime_details.json'));

    final tAnimeDetailsModel = AnimeDetailsModel.fromJson(tdecodedData);

    final tId = 1095;

     test(
      '''should perform a GET request on a URL with number list
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSourceImpl.processResponse(url);
        // assert
        verify(mockHttpClient.get(
          url,
          headers: {
             HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ));
      },
    );

    test('should return AnimeModel when the response code is 200 (success)', () async {

      //arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSourceImpl.getAnimeDetails(tId);
      // assert
      expect(result, equals(tAnimeDetailsModel));


    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSourceImpl.processResponse;
      // assert
      expect(() => call(url), throwsA(TypeMatcher<ServerException>()));
    });


  });

  });
}