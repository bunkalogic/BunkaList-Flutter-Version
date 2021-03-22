import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_movies.dart';
import 'package:dartz/dartz.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';


class TopsMoviesBloc extends Bloc<TopsMoviesEvent, TopsMoviesState> {
  
  final GetTopsMovies getTopsMovies;
  //final _moviesController = StreamController<Either<Failures, List<MovieEntity>>.broadcast() ;

  TopsMoviesBloc
  ({@required GetTopsMovies movies}) 
  : assert(movies != null),
  getTopsMovies = movies;
  
  
  
  @override
  TopsMoviesState get initialState => EmptyMovies();


  @override
  Stream<Transition<TopsMoviesEvent, TopsMoviesState>> 
   transformEvents(
     Stream<TopsMoviesEvent> events, 
     Stream<Transition<TopsMoviesEvent, TopsMoviesState>> Function(TopsMoviesEvent event) transitionFn) {
    
    return events
    .debounceTime(const Duration(milliseconds: 300))
    .switchMap(transitionFn);
    
    // return super.transformEvents( 
    //   (events as Observable<TopsMoviesEvent>).debounceTime(
    //     Duration(milliseconds: 500),
    //   ), 
    //   next
    // );
  }

  

  @override
  Stream<TopsMoviesState> mapEventToState(
    TopsMoviesEvent event,
  ) async* {
    final currentState = state;

    if(event is GetMoviesTops && !_hasReachedMax(currentState)){

      if(currentState is EmptyMovies){
      final inputEither = GetTopId().getValidateTopId(event.topId);

        yield* inputEither.fold(
          (failures) async* {
            yield ErrorMovies(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(topId) async* {
          //yield LoadingMovies();
          final failureOrMovies = await getTopsMovies(Params(topTypeId: topId, page: event.page));
          
          yield* _eitherLoadedOrErrorState(failureOrMovies, topId);
          return; 
        });
      }

      if(currentState is LoadedMovies){
        final inputEither = GetTopId().getValidateTopId(event.topId);

        yield* inputEither.fold(
        (failures) async* {
          yield ErrorMovies(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          //yield LoadingMovies();
          
          final failureOrMovies = await getTopsMovies(Params(topTypeId: topId, page: event.page));
          
           yield failureOrMovies.fold(
            (failure) => ErrorMovies(message: _mapFailureToMessage(failure)), 
            (movies)  {

              if (movies.isEmpty) {
                return currentState.copyWith(hasReachedMax: true, latestPage: event.page, latestTopId: topId);
              } else {
        
                return LoadedMovies(
                  movies: (currentState.latestTopId == topId) ? currentState.movies + movies : movies, 
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

  Stream<TopsMoviesState> _eitherLoadedOrErrorState
  (Either<Failures, List<MovieEntity>> either, int topId) async* {
    yield either.fold(
      (failure) => ErrorMovies(message: _mapFailureToMessage(failure)), 
      (movies)  => LoadedMovies(movies: movies, hasReachedMax: false, latestPage: 1, latestTopId: topId)
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

  bool _hasReachedMax(TopsMoviesState state) =>
      state is LoadedMovies && state.hasReachedMax;

}
