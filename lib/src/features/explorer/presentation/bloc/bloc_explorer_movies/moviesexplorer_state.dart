part of 'moviesexplorer_bloc.dart';

@immutable
abstract class MoviesExplorerState extends Equatable {
  const MoviesExplorerState([List props = const []]) : super(props);
}

class MoviesExplorerInitial extends MoviesExplorerState {}

class MoviesExplorerLoading extends MoviesExplorerState {}

class LoadedExplorerMovies extends MoviesExplorerState{
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int latestPage;
  final String latestSortBy;
  final int latestYear;

     LoadedExplorerMovies({
    this.movies,
    this.hasReachedMax,
    this.latestPage,
    this.latestSortBy,
    this.latestYear

  }): super([movies, hasReachedMax, latestPage, latestSortBy, latestYear]);

  LoadedExplorerMovies copyWith({
    List<MovieEntity> movies,
    bool hasReachedMax,
    int latestPage,
    String latestSortBy,
    int latestYear,
  }) {
    return LoadedExplorerMovies(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestSortBy: this.latestSortBy,
      latestYear: this.latestYear
    );
  }  
}

class ErrorExplorerMovies extends MoviesExplorerState{
  final String message;
  ErrorExplorerMovies({@required this.message});

  @override
  List<Object> get props => [message];
}