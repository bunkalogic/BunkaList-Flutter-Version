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

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';


class TopsMoviesBloc extends Bloc<TopsMoviesEvent, TopsMoviesState> {
  
  final GetTopsMovies getTopsMovies;

  TopsMoviesBloc
  ({@required GetTopsMovies movies}) 
  : assert(movies != null),
  getTopsMovies = movies;
  
  
  
  @override
  TopsMoviesState get initialState => Empty();

  @override
  Stream<TopsMoviesState> mapEventToState(
    TopsMoviesEvent event,
  ) async* {
    if(event is GetMoviesTops){
      final inputEither = GetTopId().getValidateTopId(event.topId);

      yield* inputEither.fold(
        (failures) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          yield Loading();
          final failureOrMovies = await getTopsMovies(Params(topTypeId: topId));
          
          yield* _eitherLoadedOrErrorState(failureOrMovies); 
        });
    }
  }

  Stream<TopsMoviesState> _eitherLoadedOrErrorState
  (Either<Failures, List<MovieEntity>> either) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)), 
      (movies)  => Loaded(movies: movies)
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
