import 'dart:async';
import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/explorer/domain/usescases/get_explorer_series.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';


part 'series_explorer_event.dart';
part 'series_explorer_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';

class SeriesExplorerBloc extends Bloc<SeriesExplorerEvent, SeriesExplorerState> {

  final GetExplorerSeries getExplorerSeries;

  SeriesExplorerBloc({@required GetExplorerSeries explorerSeries})
  : assert(explorerSeries != null),
  getExplorerSeries = explorerSeries;



  @override
  SeriesExplorerState get initialState => SeriesExplorerInitial();

  @override
  Stream<Transition<SeriesExplorerEvent, SeriesExplorerState>> transformEvents(
    Stream<SeriesExplorerEvent> events, 
    Stream<Transition<SeriesExplorerEvent, SeriesExplorerState>> Function(SeriesExplorerEvent event) transitionFn) {
    
    return events
    .debounceTime(const Duration(milliseconds: 300))
    .switchMap(transitionFn);
    
    // return super.transformEvents( 
    //   (events as Observable<SeriesExplorerEvent>).debounceTime(
    //     Duration(milliseconds: 500),
    //   ), 
    //   next
    // );
  }

  

  @override
  Stream<SeriesExplorerState> mapEventToState(
    SeriesExplorerEvent event,
  ) async* {
    
    final currentState = state;

    if(event is GetSeriesExplorer && !_hasReachedMax(currentState)){
      final inputEither = GetTopId().getValidateTopId(event.page);

      if( currentState is SeriesExplorerInitial){
        yield* inputEither.fold(
          (failures) async* {
            yield ErrorExplorerSeries(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          //yield LoadingSeries();
          final failureOrSeries = await getExplorerSeries(Params( 
            page: page,
            genre: event.genre,
            sortBy: event.sortBy,
            voteCountGte: event.voteCountGte,
            withKeywords: event.withKeywords,
            withNetwork: event.withNetwork,
            year: event.year

          ));
          
          yield* _eitherLoadedOrErrorState(failureOrSeries);
          return; 
        });
      }
       


        if(currentState is LoadedExplorerSeries){
        final inputEither = GetTopId().getValidateTopId(event.page);


       yield* inputEither.fold(
          (failures) async* {
            yield ErrorExplorerSeries(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          //yield LoadingSeries();
          final failureOrSeries = await getExplorerSeries(Params( 
            page: page,
            genre: event.genre,
            sortBy: event.sortBy,
            voteCountGte: event.voteCountGte,
            withKeywords: event.withKeywords,
            withNetwork: event.withNetwork,
            year: event.year

          ));
          
           yield failureOrSeries.fold(
            (failure) => ErrorExplorerSeries(message: _mapFailureToMessage(failure)), 
            (series)  {

              if (series.isEmpty) {
                return currentState.copyWith(
                  hasReachedMax: true, 
                  latestPage: event.page, 
                  latestSortBy: event.sortBy, 
                  latestYear: event.year
                );
              } else {

                final allSeries = currentState.series + series;

        
                return LoadedExplorerSeries(
                  series: (currentState.latestYear == event.year && currentState.latestSortBy == event.sortBy) 
                  ? allSeries
                  : series, 
                  hasReachedMax: false, 
                  latestPage: event.page,
                  latestSortBy: event.sortBy, 
                  latestYear: event.year
                );

              }
            });

          
        });


      }
    }


  }


  Stream<SeriesExplorerState> _eitherLoadedOrErrorState
  (Either<Failures, List<SeriesEntity>> either) async* {
    yield either.fold(
      (failure) => ErrorExplorerSeries(message: _mapFailureToMessage(failure)), 
      (series)  => LoadedExplorerSeries(series: series, hasReachedMax: false, latestPage: 1, latestSortBy: ConstSortBy.popularityDesc, latestYear: 0)
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

  bool _hasReachedMax(SeriesExplorerState state) =>
      state is LoadedExplorerSeries && state.hasReachedMax;
}
