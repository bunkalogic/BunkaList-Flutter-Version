part of 'moviesexplorer_bloc.dart';

abstract class MoviesExplorerEvent extends Equatable {
  const MoviesExplorerEvent([List props = const <dynamic>[]]) : super(props);
}


class GetMoviesExplorer extends MoviesExplorerEvent{
  final int page;
  final String sortBy;
  final int year;
  final int voteCountGte;
  final String genre;
  final String withKeywords;
  final String withOriginalLanguage;

  GetMoviesExplorer({
    @required this.page,
    this.sortBy,
    this.year,
    this.voteCountGte,
    this.genre,
    this.withKeywords,
    this.withOriginalLanguage
  }) : super([
    page,
    sortBy,
    year,
    voteCountGte,
    genre,
    withKeywords,
    withOriginalLanguage,
  ]);
}
