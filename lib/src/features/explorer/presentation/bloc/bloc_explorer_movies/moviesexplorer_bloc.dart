import 'dart:async';

import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/explorer/domain/usescases/get_explorer_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'moviesexplorer_event.dart';
part 'moviesexplorer_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';

class MoviesExplorerBloc extends Bloc<MoviesExplorerEvent, MoviesExplorerState> {

  final GetExplorerMovies getExplorerMovies;

  MoviesExplorerBloc({@required GetExplorerMovies explorerMovies})
  : assert(explorerMovies != null),
  getExplorerMovies = explorerMovies;


  @override
  MoviesExplorerState get initialState => MoviesExplorerInitial();

  @override
  Stream<Transition<MoviesExplorerEvent, MoviesExplorerState>> transformEvents(
    Stream<MoviesExplorerEvent> events, 
    Stream<Transition<MoviesExplorerEvent, MoviesExplorerState>> Function(MoviesExplorerEvent event) transitionFn) {
    
    return events
    .debounceTime(const Duration(milliseconds: 300))
    .switchMap(transitionFn);
    
    // return super.transformEvents( 
    //   (events as Observable<MoviesExplorerEvent>).debounceTime(
    //     Duration(milliseconds: 500),
    //   ), 
    //   next
    // );
  }

  

  @override
  Stream<MoviesExplorerState> mapEventToState(
    MoviesExplorerEvent event,
  ) async* {
    final currentState = state;

    if(event is GetMoviesExplorer && !_hasReachedMax(currentState)){
      final inputEither = GetTopId().getValidateTopId(event.page);

      if (currentState is MoviesExplorerInitial){
        yield* inputEither.fold(
          (failures) async* {
            yield ErrorExplorerMovies(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          //yield LoadingMovies();
          final failureOrMovies = await getExplorerMovies(Params( 
            page: page,
            genre: event.genre,
            sortBy: event.sortBy,
            voteCountGte: event.voteCountGte,
            withKeywords: event.withKeywords,
            withOriginalLanguage: event.withOriginalLanguage,
            year: event.year

          ));
          
          yield* _eitherLoadedOrErrorState(failureOrMovies);
        });
      } 
      
      if(currentState is LoadedExplorerMovies){
        final inputEither = GetTopId().getValidateTopId(event.page);


        yield* inputEither.fold(
          (failures) async* {
            yield ErrorExplorerMovies(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          //yield LoadingMovies();
          final failureOrMovies = await getExplorerMovies(Params( 
            page: page,
            genre: event.genre,
            sortBy: event.sortBy,
            voteCountGte: event.voteCountGte,
            withKeywords: event.withKeywords,
            withOriginalLanguage: event.withOriginalLanguage,
            year: event.year

          ));
          
           yield failureOrMovies.fold(
            (failure) => ErrorExplorerMovies(message: _mapFailureToMessage(failure)), 
            (movies)  {

              if (movies.isEmpty) {
                return currentState.copyWith(hasReachedMax: true, latestPage: page, latestSortBy: event.sortBy, latestYear: event.year);
              }

              final allMovies = currentState.movies + movies;

                return LoadedExplorerMovies(
                  movies: (currentState.latestYear == event.year && currentState.latestSortBy == event.sortBy) 
                  ? allMovies
                  : movies, 
                  hasReachedMax: false, 
                  latestPage: page,
                  latestSortBy: event.sortBy, 
                  latestYear: event.year
                );
            });

          
        });


      }
    }

      

  }

  Stream<MoviesExplorerState> _eitherLoadedOrErrorState
  (Either<Failures, List<MovieEntity>> either) async* {
    yield either.fold(
      (failure) => ErrorExplorerMovies(message: _mapFailureToMessage(failure)), 
      (movies)  => LoadedExplorerMovies(movies: movies, hasReachedMax: false, latestPage: 1, latestSortBy: ConstSortBy.popularityDesc, latestYear: 0)
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

  bool _hasReachedMax(MoviesExplorerState state) =>
      state is LoadedExplorerMovies && state.hasReachedMax;
}
