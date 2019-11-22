

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/movie_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/movie_details_model.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements MovieDetailsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main() {
  MovieDetailsImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;


  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = MovieDetailsImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

   void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group('Get Movie All Details', (){
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these two variables throughout all the tests
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

    final tId = 25467;

    final MovieDetailsEntity tMovieDetailsEntity = tMovieDetailsModel;

  test('should check if device is online', (){

    // arrange 
    when(mockNetworkInfo.isConnected).thenAnswer( (_) async => true);
    // act
    repositoryImpl.getDetailsMovie(tId);
    // assert
    verify(mockNetworkInfo.isConnected); 

  });



  runTestsOnline((){

    test(
      'should return remote data when the call to remote data source is successful', () async {
       // arrange
       when(mockRemoteDataSource.getMovieDetails(tId) )
       .thenAnswer((_) async => tMovieDetailsModel ); 
       // act
       final result = await repositoryImpl.getDetailsMovie(tId);
       // assert
       verify(mockRemoteDataSource.getMovieDetails(tId));
       expect(result, equals(Right(tMovieDetailsEntity)));

    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetails(any))
          .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getDetailsMovie(tId);
        //assert
        verify(mockRemoteDataSource.getMovieDetails(tId));

        expect(result, equals(Left(ServerFailure())));
        

    });


  });



  });

}
