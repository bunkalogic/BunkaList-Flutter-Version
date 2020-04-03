import 'dart:async';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_series.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'seriesair_event.dart';
part 'seriesair_state.dart';


const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Series';

class SeriesAirBloc extends Bloc<SeriesAirEvent, SeriesAirState> {
  
  final GetTopsSeries getTopsSeries;

  SeriesAirBloc
  ({@required GetTopsSeries series}) 
  : assert(series != null),
  getTopsSeries = series;
  
  
  @override
  SeriesAirState get initialState => SeriesAirInitial();

  @override
  Stream<SeriesAirState> mapEventToState(
    SeriesAirEvent event,
  ) async* {
     if(event is GetSeriesAirInMonth){
      final inputEither = GetTopId().getValidateTopId(event.topId);

      yield* inputEither.fold(
        (failures) async* {
          yield ErrorSeries(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          yield LoadingSeries();
          final failureOrSeries = await getTopsSeries(Params(topTypeId: topId, page: event.page));
          
          yield* _eitherLoadedOrErrorState(failureOrSeries); 
        });
    }
  }

  Stream<SeriesAirState> _eitherLoadedOrErrorState
  (Either<Failures, List<SeriesEntity>> either) async* {
    yield either.fold(
      (failure) => ErrorSeries(message: _mapFailureToMessage(failure)), 
      (series)  => LoadedSeries(series: series)
    );
  }
  
  String _mapFailureToMessage(Failures failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
