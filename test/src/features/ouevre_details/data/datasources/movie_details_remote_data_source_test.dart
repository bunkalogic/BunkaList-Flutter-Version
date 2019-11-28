

import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/movie_details_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http ;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  
  MovieDetailsRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp((){

    mockHttpClient = MockHttpClient();
    dataSourceImpl = MovieDetailsRemoteDataSourceImpl(client: mockHttpClient);

  });

  group('get All Details Movie', (){

    void setUpMockHttpClientSuccess200(){

      when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('movie_details.json'), 200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        }
        ));

    }

    void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
    }

  group('Get All Details Movie Response', () {

    final String url = 'https://api.themoviedb.org/3/movie/496243?api_key=7bcf40aff5d7be80e294d763234a6930&language=en-US';

    final tdecodedData = json.decode(fixture('movie_details.json'));

    final tMovieDetailsModel = MovieDetailsModel.fromJson(tdecodedData);

    final tId = 496243;

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

    test('should return MovieModel when the response code is 200 (success)', () async {

      //arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSourceImpl.getMovieDetails(tId);
      // assert
      expect(result, equals(tMovieDetailsModel));


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