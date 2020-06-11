import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_series.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:equatable/equatable.dart';

part 'selectionseries_event.dart';
part 'selectionseries_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Series';

class SelectionseriesBloc extends Bloc<SelectionseriesEvent, SelectionseriesState> {

  final GetTopsSeries getTopsSeries;

  SelectionseriesBloc
  ({@required GetTopsSeries series}) 
  : assert(series != null),
  getTopsSeries = series;

  @override
  SelectionseriesState get initialState => SelectionseriesInitial();

  @override
  Stream<SelectionseriesState> mapEventToState(
    SelectionseriesEvent event,
  ) async* {
    if(event is GetSelectionSeriesMonth){
      final inputEither = GetTopId().getValidateTopId(event.topId);

      yield* inputEither.fold(
        (failures) async* {
          yield ErrorSelectionSeries(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          yield LoadingSelectionSeries();
          final failureOrSeries = await getTopsSeries(Params(topTypeId: topId, page: event.page));
          
          yield* _eitherLoadedOrErrorState(failureOrSeries); 
        });
    }
  }

  Stream<SelectionseriesState> _eitherLoadedOrErrorState
  (Either<Failures, List<SeriesEntity>> either) async* {
    yield either.fold(
      (failure) => ErrorSelectionSeries(message: _mapFailureToMessage(failure)), 
      (series)  => LoadedSelectionSeries(series: series)
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
