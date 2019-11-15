import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_movies.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockGetTopsMovies extends Mock 
implements GetTopsMovies{}

main() {
  TopsMoviesBloc bloc;
  MockGetTopsMovies mockGetTopsMovies;

  setUp((){

    mockGetTopsMovies = MockGetTopsMovies();

    bloc = TopsMoviesBloc(movies: mockGetTopsMovies);

  });

  test('initialState should be Empty', (){
    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTopsMovies', (){
      final tTypeTop = Constants.topsMoviesCrimeId;

      final tMovieEntity = MovieEntity(
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
        type             : 'movie' 
      );

      final List<MovieEntity> tmovieList = new List();

      tmovieList.add(tMovieEntity);
      tmovieList.add(tMovieEntity);
      tmovieList.add(tMovieEntity);



    test('should get data from the tops movies use case', () async {
      when(mockGetTopsMovies(any)).thenAnswer((_) async => Right(tmovieList));

      bloc.add(GetMoviesTops(tTypeTop));

      await untilCalled(mockGetTopsMovies(any));

      verify(mockGetTopsMovies(Params(topTypeId: tTypeTop)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      // arrange
      when(mockGetTopsMovies(any))
      .thenAnswer((_) async => Right(tmovieList));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(movies: tmovieList)
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetMoviesTops(tTypeTop));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange 
      when(mockGetTopsMovies(any))
      .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetMoviesTops(tTypeTop));
    });


    }

    
  );


}
