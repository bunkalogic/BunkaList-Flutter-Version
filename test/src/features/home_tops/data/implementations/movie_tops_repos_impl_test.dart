
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_movie_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/movie_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements TopsMovieRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main() {
  MovieTopsRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = MovieTopsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('get Tops Movies',  (){
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these two variables throughout all the tests
    final tMovieModel = MovieModel(
      posterPath       : "null",
      adult            : false,
      overview         : 'test',
      releaseDate      : '22/11/1999',
      genreIds         : [16, 34],
      id               : 200,
      originalTitle    : 'original title test',
      originalLanguage : 'es',
      title            : 'title test',
      backdropPath     : 'null',
      popularity       : 2344.00,
      voteCount        : 346,
      video            : true,
      voteAverage      : 345.0,
  );
    final movies = new Movies();
    movies.items.add(tMovieModel);
    movies.items.add(tMovieModel);

  final List<MovieModel> tmoviesList = movies.items;

  final List<MovieEntity>  tMovieEntity = tmoviesList;

  final topsId = 1;

  test('should check if device is online', (){

    // arrange 
    when(mockNetworkInfo.isConnected).thenAnswer( (_) async => true);
    // act
    repositoryImpl.getTopsMovies(topsId);
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
       when(mockRemoteDataSource.getTopsMovies(topsId))
       .thenAnswer((_) async => tmoviesList ); 
       // act
       final result = await repositoryImpl.getTopsMovies(topsId);
       // assert
       verify(mockRemoteDataSource.getTopsMovies(topsId));
       expect(result, equals(Right(tMovieEntity)));

    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getTopsMovies(any))
          .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getTopsMovies(topsId);
        //assert
        verify(mockRemoteDataSource.getTopsMovies(topsId));

        expect(result, equals(Left(ServerFailure())));
        

    });

  });

  });

  
}

