import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_series.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockGetTopsSeries extends Mock 
implements GetTopsSeries{}

main() {
  TopsSeriesBloc bloc;
  MockGetTopsSeries mockGetTopsSeries;

  setUp((){

    mockGetTopsSeries = MockGetTopsSeries();

    bloc = TopsSeriesBloc(series: mockGetTopsSeries);

  });

  test('initialState should be Empty', (){
    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTopsSeries', (){
      final tTypeTop = Constants.topsSeriesFantasyAndSciFiId;

      final tserieEntity = SeriesEntity(
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
        type             : 'tv' 
      );

      final List<SeriesEntity> tserieList = new List();

      tserieList.add(tserieEntity);
      tserieList.add(tserieEntity);
      tserieList.add(tserieEntity);



    test('should get data from the Tops Series use case', () async {
      when(mockGetTopsSeries(any)).thenAnswer((_) async => Right(tserieList));

      bloc.dispatch(GetSeriesTops(tTypeTop));

      await untilCalled(mockGetTopsSeries(any));

      verify(mockGetTopsSeries(Params(topTypeId: tTypeTop)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      // arrange
      when(mockGetTopsSeries(any))
      .thenAnswer((_) async => Right(tserieList));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(series: tserieList)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(GetSeriesTops(tTypeTop));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange 
      when(mockGetTopsSeries(any))
      .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      // act
      bloc.dispatch(GetSeriesTops(tTypeTop));
    });


    }

    
  );


}
