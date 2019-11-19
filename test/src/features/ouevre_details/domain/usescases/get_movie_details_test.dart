import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetMovieDetails extends Mock 
  implements MovieDetailsContract {}

  void main(){

    GetMovieDetails usecase;
    MockGetMovieDetails mockGetMovieDetails;

    setUp((){

      mockGetMovieDetails = MockGetMovieDetails();

      usecase = GetMovieDetails(mockGetMovieDetails);

    });

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

    final int tMovieId =  25467;

    test('Get All details of Movie from de Contract', () async {

      when( mockGetMovieDetails.getDetailsMovie(any))
        .thenAnswer((_) async => Right(tMovieDetailsEntity));

      final result = await usecase(Params(movieId: tMovieId ));

      expect(result, Right(tMovieDetailsEntity));

      verify(mockGetMovieDetails.getDetailsMovie(tMovieId));   

      verifyNoMoreInteractions(mockGetMovieDetails);

    });

  }