import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_anime.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockGetTopsAnimes extends Mock 
implements GetTopsAnime{}

main() {
  TopsAnimesBloc bloc;
  MockGetTopsAnimes mockGetTopsAnimes;

  setUp((){

    mockGetTopsAnimes = MockGetTopsAnimes();

    bloc = TopsAnimesBloc(animes: mockGetTopsAnimes);

  });

  test('initialState should be Empty', (){
    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTopsAnimes', (){
      final tTypeTop = Constants.topsAnimeSliceOfLifeId;

      final tanimeEntity = AnimeEntity(
        posterPath       : "null",
        overview         : 'test',
        firstAirDate     : '22/11/1999',
        genreIds         : [18, 34],
        id               : 200,
        originalName     : 'original title test',
        originalLanguage : 'es',
        name             : 'title test',
        backdropPath     : 'null',
        popularity       : 2344.00,
        voteCount        : 346,
        originCountry    : ['Fr'],
        voteAverage      : 345.0,
        type             : 'anime' 
      );

      final List<AnimeEntity> tanimeList = new List();

      tanimeList.add(tanimeEntity);
      tanimeList.add(tanimeEntity);
      tanimeList.add(tanimeEntity);



    test('should get data from the Tops Animes use case', () async {
      when(mockGetTopsAnimes(any)).thenAnswer((_) async => Right(tanimeList));

      bloc.dispatch(GetAnimesTops(tTypeTop));

      await untilCalled(mockGetTopsAnimes(any));

      verify(mockGetTopsAnimes(Params(topTypeId: tTypeTop)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      // arrange
      when(mockGetTopsAnimes(any))
      .thenAnswer((_) async => Right(tanimeList));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(animes: tanimeList)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(GetAnimesTops(tTypeTop));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange 
      when(mockGetTopsAnimes(any))
      .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(GetAnimesTops(tTypeTop));
    });


    }

    
  );


}
