import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_series_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/series_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/data/models/series_model.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements TopsSeriesRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main() {
  SeriesTopRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = SeriesTopRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

   group('get Tops Series',  (){
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these two variables throughout all the tests
    final tMovieModel = SeriesModel(
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
    final series = new Series();
    series.items.add(tMovieModel);
    series.items.add(tMovieModel);

  final List<SeriesModel> tSeriesList = series.items;

  final List<SeriesEntity>  tSeriesEntity = tSeriesList;

  final topsId = 1;

  test('should check if device is online', (){

    // arrange 
    when(mockNetworkInfo.isConnected).thenAnswer( (_) async => true);
    // act
    repositoryImpl.getTopsSeries(topsId);
    // assert
    verify(mockNetworkInfo.isConnected); 

  });

  group('device is online', (){
    
    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
      'should return remote data when the call to remote data source is successful', () async {
       // arrange
       when(mockRemoteDataSource.getTopsSeries(topsId))
       .thenAnswer((_) async => tSeriesList ); 
       // act
       final result = await repositoryImpl.getTopsSeries(topsId);
       // assert
       verify(mockRemoteDataSource.getTopsSeries(topsId));
       expect(result, equals(Right(tSeriesEntity)));

    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getTopsSeries(any))
          .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getTopsSeries(topsId);
        //assert
        verify(mockRemoteDataSource.getTopsSeries(topsId));

        expect(result, equals(Left(ServerFailure())));
        

    });

  });

  });
}

