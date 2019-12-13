import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/anime_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/anime_details_model.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements AnimeDetailsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main() {
  AnimeDetailsImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;


  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = AnimeDetailsImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('Get Anime All Details', (){
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these two variables throughout all the tests
    final tAnimeDetailsModel = AnimeDetailsModel(
      backdropPath:  '/null',
      episodeRunTime: [16, 18] ,
      firstAirDate: '2/10/2010' ,
      genres: List<GenreAnimeModel>(),
      homepage: 'null',
      id: 3245,
      inProduction: false,
      languages: ['ja', 'en'],
      lastAirDate: '2/10/2010' ,
      name: 'Name',
      networks: List<NetworkAnimeModel>(),
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
      seasonAnime: List<SeasonAnimeModel>()
    );

    final tId = 3245;

    final AnimeDetailsEntity tAnimeDetailsEntity = tAnimeDetailsModel;

  test('should check if device is online', (){

    // arrange 
    when(mockNetworkInfo.isConnected).thenAnswer( (_) async => true);
    // act
    repositoryImpl.getDetailsAnime(tId);
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
       when(mockRemoteDataSource.getAnimeDetails(tId) )
       .thenAnswer((_) async => tAnimeDetailsModel ); 
       // act
       final result = await repositoryImpl.getDetailsAnime(tId);
       // assert
       verify(mockRemoteDataSource.getAnimeDetails(tId));
       expect(result, equals(Right(tAnimeDetailsEntity)));

    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getAnimeDetails(any))
          .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getDetailsAnime(tId);
        //assert
        verify(mockRemoteDataSource.getAnimeDetails(tId));

        expect(result, equals(Left(ServerFailure())));
        

    });

  });



  });

}