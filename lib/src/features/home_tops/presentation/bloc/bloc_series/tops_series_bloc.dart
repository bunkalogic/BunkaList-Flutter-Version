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
import 'package:rxdart/rxdart.dart';

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
  Stream<TopsSeriesState> transformEvents(Stream<TopsSeriesEvent> events, Stream<TopsSeriesState> Function(TopsSeriesEvent event) next) {
    return super.transformEvents( 
      (events as Observable<TopsSeriesEvent>).debounceTime(
        Duration(milliseconds: 500),
      ), 
      next
    );
  }

  @override
  Stream<TopsSeriesState> mapEventToState(
    TopsSeriesEvent event,
  ) async* {

    final currentState = state;

    if(event is GetSeriesTops && !_hasReachedMax(currentState)){
      if(currentState is EmptySeries){
        final inputEither = GetTopId().getValidateTopId(event.topId);

        yield* inputEither.fold(
          (failures) async* {
            yield ErrorSeries(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(topId) async* {
            //yield LoadingSeries();
            final failureOrSeries = await getTopsSeries(Params(topTypeId: topId, page: event.page));

            yield* _eitherLoadedOrErrorState(failureOrSeries, topId);
            return; 
        });
      }

      if(currentState is LoadedSeries){
        final inputEither = GetTopId().getValidateTopId(event.topId);

        yield* inputEither.fold(
        (failures) async* {
          yield ErrorSeries(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          //yield LoadingSeries();
          
          final failureOrSeries = await getTopsSeries(Params(topTypeId: topId, page: event.page));
          
           yield failureOrSeries.fold(
            (failure) => ErrorSeries(message: _mapFailureToMessage(failure)), 
            (series)  {

              if (series.isEmpty) {
                return currentState.copyWith(hasReachedMax: true, latestPage: event.page, latestTopId: topId);
              } else {
        
                return LoadedSeries(
                  series: (currentState.latestTopId == topId) ? currentState.series + series : series, 
                  hasReachedMax: false, 
                  latestPage: event.page,
                  latestTopId: topId 
                );

              }
            } 
          );
        });
      }
    }
    
  }

  Stream<TopsSeriesState> _eitherLoadedOrErrorState
  (Either<Failures, List<SeriesEntity>> either, int topId) async* {
    yield either.fold(
      (failure) => ErrorSeries(message: _mapFailureToMessage(failure)), 
      (series)  => LoadedSeries(series: series, hasReachedMax: false, latestPage: 1, latestTopId: topId)
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

  bool _hasReachedMax(TopsSeriesState state) =>
      state is LoadedSeries && state.hasReachedMax;
}

