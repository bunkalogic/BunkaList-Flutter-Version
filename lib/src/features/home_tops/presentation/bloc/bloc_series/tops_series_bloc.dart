import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_series.dart';
import 'package:dartz/dartz.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Series';


class TopsSeriesBloc extends Bloc<TopsSeriesEvent, TopsSeriesState> {
  
  final GetTopsSeries getTopsSeries;

  TopsSeriesBloc
  ({@required GetTopsSeries series}) 
  : assert(series != null),
  getTopsSeries = series;
  
  
  
  @override
  TopsSeriesState get initialState => EmptySeries();

  @override
  Stream<TopsSeriesState> mapEventToState(
    TopsSeriesEvent event,
  ) async* {
    if(event is GetSeriesTops){
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

  Stream<TopsSeriesState> _eitherLoadedOrErrorState
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

