part of 'moviesexplorer_bloc.dart';

abstract class MoviesExplorerState extends Equatable {
  const MoviesExplorerState([List props = const []]) : super(props);
}

class MoviesExplorerInitial extends MoviesExplorerState {}

class MoviesExplorerLoading extends MoviesExplorerState {}

class LoadedExplorerMovies extends MoviesExplorerState{
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int latestPage;

     LoadedExplorerMovies({
    this.movies,
    this.hasReachedMax,
    this.latestPage,
  }): super([movies, hasReachedMax, latestPage]);

  LoadedExplorerMovies copyWith({
    List<MovieEntity> movies,
    bool hasReachedMax,
    int latestPage,
  }) {
    return LoadedExplorerMovies(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
    );
  }  
}

class ErrorExplorerMovies extends MoviesExplorerState{
  final String message;
  ErrorExplorerMovies({@required this.message});

  @override
  List<Object> get props => [message];
}