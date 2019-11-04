import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsMoviesState extends Equatable {
TopsMoviesState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TopsMoviesState{}

class Loading extends TopsMoviesState{}

class Loaded extends TopsMoviesState{
  final List<MovieEntity> movies;

  Loaded({@required this.movies}) : super([movies]);
}

class Error extends TopsMoviesState{
  final String message;
  Error({@required this.message}) : super([message]);
}
