import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart' as animeE ;
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart' as serieE ;
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_series_details.dart';

import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details.dart' as animeP ;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details.dart' as movieP ;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_series_details.dart'as serieP ;


import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetDetailsMovie extends Mock 
implements GetMovieDetails{}

class MockGetDetailsSerie extends Mock 
implements GetSerieDetails{}

class MockGetDetailsAnime extends Mock 
implements GetAnimeDetails{}


main() {
  
  OuevreDetailsBloc bloc;
  MockGetDetailsMovie mockGetDetailsMovie;
  MockGetDetailsSerie mockGetDetailsSerie;
  MockGetDetailsAnime mockGetDetailsAnime;

  setUp((){

    mockGetDetailsMovie = MockGetDetailsMovie();
    mockGetDetailsSerie = MockGetDetailsSerie();
    mockGetDetailsAnime = MockGetDetailsAnime();

    bloc = OuevreDetailsBloc(
      movie: mockGetDetailsMovie,
      serie: mockGetDetailsSerie,
      anime: mockGetDetailsAnime
    );

  });

  test('initialState should Empty', (){

    //assert
    expect(bloc.initialState, equals(Empty()));

  });

  group('Get Movies All Details', (){

    final tId = 2109;

    final tCorrectType = 'movie';
    
    final tMovieDetailsEntity = MovieDetailsEntity(
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
      type: 'movie' ,
    );

    test('should get data from the movie details use case', () async {
      when(mockGetDetailsMovie(any)).thenAnswer((_) async => Right(tMovieDetailsEntity));

      bloc.add(GetDetailsOuevre(tId, tCorrectType));

      await untilCalled(mockGetDetailsMovie(any));

      verify(mockGetDetailsMovie(movieP.Params(movieId: tId)));
    });

    test('should emit [Loading, LoadedMovie] when data is gotten successfully', () async {
        when(mockGetDetailsMovie(any))
        .thenAnswer((_) async => Right(tMovieDetailsEntity));
        
        final expected = [
          Empty(),
          Loading(),
          LoadedMovie(movie: tMovieDetailsEntity)
        ];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetDetailsOuevre(tId, tCorrectType));
    });

    test('should emit [Loading, Error] when getting data fails in Movie Details', () async {
      // arrange 
      when(mockGetDetailsMovie(any))
      .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetDetailsOuevre(tId, tCorrectType));
    });

  });



  group('Get Serie All Details', (){

    final tId = 2109;

    final tCorrectType = 'tv';

    final tSerieDetailsEntity = SerieDetailsEntity(
      backdropPath:  '/null',
      episodeRunTime: [18] ,
      firstAirDate: '2/10/2010' ,
      genres: [18],
      homepage: 'null',
      id: 3245,
      inProduction: false,
      languages: ['en'],
      lastAirDate: '2/10/2010' ,
      name: 'Name',
      networks: List<serieE.Network>(),
      numberOfEpisodes: 40,
      numberOfSeasons: 3,
      originCountry: ['us'],
      originalLanguage: 'us',
      originalName: 'Original Name',
      overview: 'lorem inpsum',
      popularity: 3290.90,
      posterPath: '/null',
      status: 'finish',
      voteAverage: 8.5,
      voteCount: 34,
      type: 'tv',
    );

    test('should get data from the Serie details use case', () async {
      when(mockGetDetailsSerie(any)).thenAnswer((_) async => Right(tSerieDetailsEntity));

      bloc.add(GetDetailsOuevre(tId, tCorrectType));

      await untilCalled(mockGetDetailsSerie(any));

      verify(mockGetDetailsSerie(serieP.Params(serieId: tId)));
    });


    test('should emit [Loading, LoadedSerie] when data is gotten successfully', () async {
        when(mockGetDetailsSerie(any))
        .thenAnswer((_) async => Right(tSerieDetailsEntity));
        
        final expected = [
          Empty(),
          Loading(),
          LoadedSerie(serie: tSerieDetailsEntity)
        ];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetDetailsOuevre(tId, tCorrectType));
    });

    test('should emit [Loading, Error] when getting data fails in Serie Details', () async {
      // arrange 
      when(mockGetDetailsSerie(any))
      .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetDetailsOuevre(tId, tCorrectType));
    });


  });



  group('Get Anime All Details', (){

    final tId = 2109;

    final tCorrectType = 'anime'; 

    final tAnimeDetailsEntity = AnimeDetailsEntity(
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
      networks: List<animeE.Network>(),
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
      type: 'anime',
    );

    test('should get data from the Anime details use case', () async {
      when(mockGetDetailsAnime(any)).thenAnswer((_) async => Right(tAnimeDetailsEntity));

      bloc.add(GetDetailsOuevre(tId, tCorrectType));

      await untilCalled(mockGetDetailsAnime(any));

      verify(mockGetDetailsAnime(animeP.Params(animeId: tId)));
    });

    test('should emit [Loading, LoadedAnime] when data is gotten successfully', () async {
        when(mockGetDetailsAnime(any))
        .thenAnswer((_) async => Right(tAnimeDetailsEntity));
        
        final expected = [
          Empty(),
          Loading(),
          LoadedAnime(anime: tAnimeDetailsEntity)
        ];

        expectLater(bloc, emitsInOrder(expected));

        bloc.add(GetDetailsOuevre(tId, tCorrectType));
    });

    test('should emit [Loading, Error] when getting data fails in Anime Details', () async {
      // arrange 
      when(mockGetDetailsAnime(any))
      .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetDetailsOuevre(tId, tCorrectType));
    });




  });

  
}