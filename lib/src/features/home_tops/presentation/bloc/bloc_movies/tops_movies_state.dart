import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsMoviesState extends Equatable {
TopsMoviesState([List props = const <dynamic>[]]) : super(props);
}

class EmptyMovies extends TopsMoviesState{}

class LoadingMovies extends TopsMoviesState{}

class LoadedMovies extends TopsMoviesState{
  final List<MovieEntity> movies;

  LoadedMovies({@required this.movies}) : super([movies]);
}

class ErrorMovies extends TopsMoviesState{
  final String message;
  ErrorMovies({@required this.message}) : super([message]);
}
