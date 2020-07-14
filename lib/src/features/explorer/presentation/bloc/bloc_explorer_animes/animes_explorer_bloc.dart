import 'dart:async';

import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/explorer/domain/usescases/get_explorer_animes.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';


part 'animes_explorer_event.dart';
part 'animes_explorer_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';

class AnimesExplorerBloc extends Bloc<AnimesExplorerEvent, AnimesExplorerState> {

  final GetExplorerAnime getExplorerAnime;

  AnimesExplorerBloc({@required GetExplorerAnime explorerAnime})
  : assert(explorerAnime != null),
  getExplorerAnime = explorerAnime;

  @override
  AnimesExplorerState get initialState => AnimesExplorerInitial();

   @override
  Stream<AnimesExplorerState> transformEvents(Stream<AnimesExplorerEvent> events, Stream<AnimesExplorerState> Function(AnimesExplorerEvent event) next) {
    return super.transformEvents( 
      (events as Observable<AnimesExplorerEvent>).debounceTime(
        Duration(milliseconds: 500),
      ), 
      next
    );
  }

  @override
  Stream<AnimesExplorerState> mapEventToState(
    AnimesExplorerEvent event,
  ) async* {
    
    final currentState = state;

    if(event is GetAnimesExplorer && !_hasReachedMax(currentState)){
      final inputEither = GetTopId().getValidateTopId(event.page);

      if(currentState is AnimesExplorerInitial){
        yield* inputEither.fold(
          (failures) async* {
            yield ErrorExplorerAnimes(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          //yield LoadingAnimes();
          final failureOrAnimes = await getExplorerAnime(Params( 
            page: page,
            genre: event.genre,
            sortBy: event.sortBy,
            voteCountGte: event.voteCountGte,
            withKeywords: event.withKeywords,
            withNetwork: event.withNetwork,
            year: event.year

          ));
          
          yield* _eitherLoadedOrErrorState(failureOrAnimes);
          return; 
        });
      }
       


        if(currentState is LoadedExplorerAnimes){
        final inputEither = GetTopId().getValidateTopId(event.page);


       yield* inputEither.fold(
          (failures) async* {
            yield ErrorExplorerAnimes(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          //yield LoadingAnimes();
          final failureOrAnimes = await getExplorerAnime(Params( 
            page: page,
            genre: event.genre,
            sortBy: event.sortBy,
            voteCountGte: event.voteCountGte,
            withKeywords: event.withKeywords,
            withNetwork: event.withNetwork,
            year: event.year

          ));
          
           yield failureOrAnimes.fold(
            (failure) => ErrorExplorerAnimes(message: _mapFailureToMessage(failure)), 
            (animes)  {

              if (animes.isEmpty) {
                return currentState.copyWith(
                  hasReachedMax: true, 
                  latestPage: event.page,
                  latestSortBy: ConstSortBy.popularityDesc, 
                  latestYear: 0
                );
              } else {

                 final allAnimes = currentState.animes + animes;

        
                return LoadedExplorerAnimes(
                  animes: (currentState.latestYear == event.year || currentState.latestSortBy == event.sortBy) 
                  ? allAnimes
                  : animes, 
                  hasReachedMax: false, 
                  latestPage: event.page,
                );

              }
            });

          
        });


      }
    }


  }


  Stream<AnimesExplorerState> _eitherLoadedOrErrorState
  (Either<Failures, List<AnimeEntity>> either) async* {
    yield either.fold(
      (failure) => ErrorExplorerAnimes(message: _mapFailureToMessage(failure)), 
      (animes)  => LoadedExplorerAnimes(animes: animes, hasReachedMax: false, latestPage: 1,latestSortBy: ConstSortBy.popularityDesc, latestYear: 0)
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

  bool _hasReachedMax(AnimesExplorerState state) =>
      state is LoadedExplorerAnimes && state.hasReachedMax;
}
