import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_anime.dart';
import 'package:dartz/dartz.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';


class TopsAnimesBloc extends Bloc<TopsAnimesEvent, TopsAnimesState> {
  
  final GetTopsAnime getTopsAnimes;

  TopsAnimesBloc
  ({@required GetTopsAnime animes}) 
  : assert(animes != null),
  getTopsAnimes = animes;
  
  
  
  @override
  TopsAnimesState get initialState => EmptyAnimes();


  @override
  Stream<Transition<TopsAnimesEvent, TopsAnimesState>> transformEvents(
    Stream<TopsAnimesEvent> events, 
    Stream<Transition<TopsAnimesEvent, TopsAnimesState>> Function(TopsAnimesEvent event) transitionFn) {
    
    return events
    .debounceTime(const Duration(milliseconds: 300))
    .switchMap(transitionFn);

    // return super.transformEvents( 
    //   (events as Observable<TopsAnimesEvent>).debounceTime(
    //     Duration(milliseconds: 500),
    //   ), 
    //   next
    // );
  }

  

  @override
  Stream<TopsAnimesState> mapEventToState(
    TopsAnimesEvent event,
  ) async* {
    final currentState = state;

    if(event is GetAnimesTops && !_hasReachedMax(currentState)){
      
      if(currentState is EmptyAnimes){
        final inputEither = GetTopId().getValidateTopId(event.topId);

      yield* inputEither.fold(
        (failures) async* {
          yield ErrorAnimes(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          //yield LoadingAnimes();
          final failureOrAnimes = await getTopsAnimes(Params(topTypeId: topId, page: event.page));
          
          yield* _eitherLoadedOrErrorState(failureOrAnimes, topId);
          return; 
        });
      }

      if(currentState is LoadedAnimes){
        final inputEither = GetTopId().getValidateTopId(event.topId);

        yield* inputEither.fold(
        (failures) async* {
          yield ErrorAnimes(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          //yield LoadingAnimes();
          
          final failureOrAnimes = await getTopsAnimes(Params(topTypeId: topId, page: event.page));
          
           yield failureOrAnimes.fold(
            (failure) => ErrorAnimes(message: _mapFailureToMessage(failure)), 
            (animes)  {

              if (animes.isEmpty) {
                return currentState.copyWith(hasReachedMax: true, latestPage: event.page, latestTopId: topId);
              } else {
        
                return LoadedAnimes(
                  animes: (currentState.latestTopId == topId) ? currentState.animes + animes : animes, 
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

  Stream<TopsAnimesState> _eitherLoadedOrErrorState
  (Either<Failures, List<AnimeEntity>> either, int topId) async* {
    yield either.fold(
      (failure) => ErrorAnimes(message: _mapFailureToMessage(failure)), 
      (animes)  => LoadedAnimes(animes: animes, hasReachedMax: false, latestPage: 1, latestTopId: topId)
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

  bool _hasReachedMax(TopsAnimesState state) =>
      state is LoadedAnimes && state.hasReachedMax;
}

