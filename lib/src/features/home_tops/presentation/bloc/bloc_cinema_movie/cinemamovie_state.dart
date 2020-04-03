part of 'cinemamovie_bloc.dart';

abstract class CinemaMovieState extends Equatable {

  const CinemaMovieState([List props = const <dynamic>[]]) : super(props);

}

class CinemaMovieInitial extends CinemaMovieState {}


class CinemaMovieLoading extends CinemaMovieState {}


class CinemaMovieLoaded extends CinemaMovieState {
  final List<MovieEntity> movies;

  CinemaMovieLoaded({@required this.movies}) : super([movies]);
}


class CinemaMovieError extends CinemaMovieState {
  final String message;
  
   CinemaMovieError({@required this.message}) : super([message]);
}
