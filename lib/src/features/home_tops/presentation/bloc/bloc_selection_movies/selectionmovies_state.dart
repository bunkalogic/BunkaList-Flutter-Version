part of 'selectionmovies_bloc.dart';

abstract class SelectionmoviesState extends Equatable {
  const SelectionmoviesState([List props = const <dynamic>[]]) : super(props);
}

class SelectionmoviesInitial extends SelectionmoviesState {}

class MovieLoading extends SelectionmoviesState {}


class MovieLoaded extends SelectionmoviesState {
  final List<MovieEntity> movies;

  MovieLoaded({@required this.movies}) : super([movies]);
}


class MovieError extends SelectionmoviesState {
  final String message;
  
   MovieError({@required this.message}) : super([message]);
}
