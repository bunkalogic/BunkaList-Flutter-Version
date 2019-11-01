import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_anime_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/models/anime_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http ;
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';



class MockHttpClient extends Mock implements http.Client {}


void main(){
  TopsAnimeRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSourceImpl = TopsAnimeRemoteDataSourceImpl(client: mockHttpClient );
  });

  group('get Tops Animes', (){

    //! FIXME: posible error del http.Response or Movies.fromList, O cambiar el client.get por http.get  

    void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('list_tops_anime.json'), 200,
        headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        }
        ));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('get Tops Anime  Response', () {
    final String url = 'https://api.themoviedb.org/3/discover/tv?api_key=7bcf40aff5d7be80e294d763234a6930&sort_by=popularity.desc&page=1&with_genres=16&include_null_first_air_dates=false&with_original_language=ja&with_keywords=9914';

    final tdecodedData = json.decode(fixture('list_tops_anime.json'));

    final tAnimeModel =
        new Animes.fromJsonList(tdecodedData['results']);
        
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

    test(
      'should return SerieModel when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSourceImpl.processResponse(url);
        // assert
        expect(result, equals(tAnimeModel.items));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSourceImpl.processResponse;
        // assert
        expect(() => call(url), throwsA(TypeMatcher<ServerException>()));
      },
    );

    // test(
    //   'should return list movie model',
    //   () async {
    //     final matcher = dataSourceImpl.getListMovieFromApi(sortBy: ConstSortBy.voteAverageDesc, voteCount: 2800); 
    //     // arrange
    //     final result = dataSourceImpl.getTopsMovies(2);

    //     // act
    //     // assert
    //     expect(result, matcher);
    //   },
    // );

  });


  });
}