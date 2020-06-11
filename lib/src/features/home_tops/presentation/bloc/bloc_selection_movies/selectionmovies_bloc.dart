import 'dart:async';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';

part 'selectionmovies_event.dart';
part 'selectionmovies_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';

class SelectionmoviesBloc extends Bloc<SelectionmoviesEvent, SelectionmoviesState> {

  final GetTopsMovies getTopsMovies;

  SelectionmoviesBloc
  ({@required GetTopsMovies movies}) 
  : assert(movies != null),
  getTopsMovies = movies;
  


  @override
  SelectionmoviesState get initialState => SelectionmoviesInitial();

  @override
  Stream<SelectionmoviesState> mapEventToState(
    SelectionmoviesEvent event,
  ) async* {
    if(event is GetSelectionMovies){

      final inputEither = GetTopId().getValidateTopId(event.topId);

      yield* inputEither.fold(
        (failure) async* {

           yield MovieError(message: INVALID_INPUT_FAILURE_MESSAGE );

        }, (topId) async* {
          yield MovieLoading();

          final failureOrMovies = await getTopsMovies(Params(topTypeId: topId, page: event.page));

          yield*  _eitherLoadedOrErrorState(failureOrMovies);
        }
      );

    }
  }

   Stream<SelectionmoviesState> _eitherLoadedOrErrorState
  (Either<Failures, List<MovieEntity>> either) async* {
    yield either.fold(
      (failure) => MovieError(message: _mapFailureToMessage(failure)), 
      (movies)  => MovieLoaded(movies: movies)
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
