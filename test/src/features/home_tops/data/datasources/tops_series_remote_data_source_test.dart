import 'dart:convert';
import 'dart:io';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_series_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/models/series_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http ;
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';



class MockHttpClient extends Mock implements http.Client {}


void main(){
  TopsSeriesRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSourceImpl = TopsSeriesRemoteDataSourceImpl(client: mockHttpClient );
  });

  group('get Tops Series TV', (){

    //! FIXME: posible error del http.Response or Movies.fromList, O cambiar el client.get por http.get  

    void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('list_tops_series.json'), 200,
        headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        }
        ));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('get Tops Series Tv Response', () {
    final String url = 'https://api.themoviedb.org/3/discover/tv?api_key=7bcf40aff5d7be80e294d763234a6930&language=en-US&sort_by=popularity.desc&page=1&vote_average.gte=8&vote_count.gte=20&with_networks=213&without_genres=16&include_null_first_air_dates=false';

    final tdecodedData = json.decode(fixture('list_tops_series.json'));

    final tMovieModel =
        new Series.fromJsonList(tdecodedData['results']);
        
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
        expect(result, equals(tMovieModel.items));
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