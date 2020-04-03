import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_cinema_movie.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:meta/meta.dart';

part 'cinemamovie_event.dart';
part 'cinemamovie_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';

class CinemaMovieBloc extends Bloc<CinemaMovieEvent, CinemaMovieState> {


  final GetCinemaMovies getCinemaMovies;

  CinemaMovieBloc({
    @required GetCinemaMovies cinemaMovies
  }) 
    : assert(cinemaMovies != null),
    getCinemaMovies = cinemaMovies;
  
  
  @override
  CinemaMovieState get initialState => CinemaMovieInitial();



  @override
  Stream<CinemaMovieState> mapEventToState(
    CinemaMovieEvent event,
  ) async* {
    if(event is GetMoviesCinema){

      final inputEither = GetTopId().getValidateTopId(event.page);

      yield* inputEither.fold(
        (failure) async* {

           yield CinemaMovieError(message: INVALID_INPUT_FAILURE_MESSAGE );

        }, (page) async* {
          yield CinemaMovieLoading();

          final failureOrMovies = await getCinemaMovies(Params(page: page));

          yield*  _eitherLoadedOrErrorState(failureOrMovies);
        }
      );

    }

  }

   Stream<CinemaMovieState> _eitherLoadedOrErrorState
  (Either<Failures, List<MovieEntity>> either) async* {
    yield either.fold(
      (failure) => CinemaMovieError(message: _mapFailureToMessage(failure)), 
      (movies)  => CinemaMovieLoaded(movies: movies)
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
