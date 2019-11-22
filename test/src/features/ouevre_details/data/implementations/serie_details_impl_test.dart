import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/serie_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/serie_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/serie_details_model.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements SerieDetailsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main() {
  SerieDetailsImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;


  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = SerieDetailsImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('Get Serie All Details', (){
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these two variables throughout all the tests
    final tSerieDetailsModel = SerieDetailsModel(
      backdropPath:  '/null',
      episodeRunTime: [16, 18] ,
      firstAirDate: '2/10/2010' ,
      genres: [16, 18],
      homepage: 'null',
      id: 3245,
      inProduction: false,
      languages: ['ja', 'en'],
      lastAirDate: '2/10/2010' ,
      name: 'Name',
      networks: List<Network>(),
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
    );

    final tId = 3245;

    final SerieDetailsEntity tSerieDetailsEntity = tSerieDetailsModel;

    test('should check if device is online', (){

    // arrange 
    when(mockNetworkInfo.isConnected).thenAnswer( (_) async => true);
    // act
    repositoryImpl.getDetailsSerie(tId);
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
       when(mockRemoteDataSource.getSerieDetails(tId) )
       .thenAnswer((_) async => tSerieDetailsModel ); 
       // act
       final result = await repositoryImpl.getDetailsSerie(tId);
       // assert
       verify(mockRemoteDataSource.getSerieDetails(tId));
       expect(result, equals(Right(tSerieDetailsEntity)));

    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getSerieDetails(any))
          .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getDetailsSerie(tId);
        //assert
        verify(mockRemoteDataSource.getSerieDetails(tId));

        expect(result, equals(Left(ServerFailure())));
        

    });

  });



  });

}