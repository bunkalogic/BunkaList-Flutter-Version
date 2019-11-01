import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_anime_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/anime_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/data/models/anime_model.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements TopsAnimeRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main() {
  AnimeTopRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = AnimeTopRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('get Tops Animes',  (){
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these two variables throughout all the tests
    final tMovieModel = AnimeModel(
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

    final anime = new Animes();
    anime.items.add(tMovieModel);
    anime.items.add(tMovieModel);

  final List<AnimeModel> tAnimeList = anime.items;

  final List<AnimeEntity>  tAnimeEntity = tAnimeList;

  final topsId = 1;

  test('should check if device is online', (){

    // arrange 
    when(mockNetworkInfo.isConnected).thenAnswer( (_) async => true);
    // act
    repositoryImpl.getTopsAnime(topsId);
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
       when(mockRemoteDataSource.getTopsAnimes(topsId))
       .thenAnswer((_) async => tAnimeList ); 
       // act
       final result = await repositoryImpl.getTopsAnime(topsId);
       // assert
       verify(mockRemoteDataSource.getTopsAnimes(topsId));
       expect(result, equals(Right(tAnimeEntity)));

    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getTopsAnimes(any))
          .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getTopsAnime(topsId);
        //assert
        verify(mockRemoteDataSource.getTopsAnimes(topsId));

        expect(result, equals(Left(ServerFailure())));
        

    });

  });

  });
}

