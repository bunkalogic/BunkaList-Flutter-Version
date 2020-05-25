import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsMoviesState extends Equatable {

  const TopsMoviesState([List props = const []]) : super(props);

}

class EmptyMovies extends TopsMoviesState{}

class LoadingMovies extends TopsMoviesState{}

class LoadedMovies extends TopsMoviesState{
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int latestPage;
  final int latestTopId;

     LoadedMovies({
    this.movies,
    this.hasReachedMax,
    this.latestPage,
    this.latestTopId
  }): super([movies, hasReachedMax, latestPage, latestTopId]);

  LoadedMovies copyWith({
    List<MovieEntity> movies,
    bool hasReachedMax,
    int latestPage,
    int latestTopId
  }) {
    return LoadedMovies(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestTopId: this.latestTopId
    );
  }  
}

class ErrorMovies extends TopsMoviesState{
  final String message;
  ErrorMovies({@required this.message});

  @override
  List<Object> get props => [message];
}
