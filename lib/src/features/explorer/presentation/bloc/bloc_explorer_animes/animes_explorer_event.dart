part of 'animes_explorer_bloc.dart';

abstract class AnimesExplorerEvent extends Equatable {
  const AnimesExplorerEvent([List props = const <dynamic>[]]) : super(props);
}

class GetAnimesExplorer extends AnimesExplorerEvent{
  final int page;
  final String sortBy;
  final int year;
  final int voteCountGte;
  final String genre;
  final String withKeywords;
  final String withNetwork;
  final String withCompanies;
  final String withWatchProvider;

  GetAnimesExplorer({
   @required this.page,
    this.sortBy,
    this.year,
    this.voteCountGte,
    this.genre,
    this.withKeywords,
    this.withNetwork,
    this.withCompanies,
    this.withWatchProvider
  }) : super([
    page,
    sortBy,
    year,
    voteCountGte,
    genre,
    withKeywords,
    withNetwork,
    withCompanies,
    withWatchProvider
  ]);
}
