part of 'animes_explorer_bloc.dart';

abstract class AnimesExplorerState extends Equatable {
  const AnimesExplorerState([List props = const []]) : super(props);
}

class AnimesExplorerInitial extends AnimesExplorerState {}

class AnimesExplorerLoading extends AnimesExplorerState {}

class LoadedExplorerAnimes extends AnimesExplorerState{
  final List<AnimeEntity> animes;
  final bool hasReachedMax;
  final int latestPage;
  final String latestSortBy;
  final int latestYear;

     LoadedExplorerAnimes({
    this.animes,
    this.hasReachedMax,
    this.latestPage,
    this.latestSortBy,
    this.latestYear
  }): super([animes, hasReachedMax, latestPage, latestSortBy, latestYear]);

  LoadedExplorerAnimes copyWith({
    List<AnimeEntity> animes,
    bool hasReachedMax,
    int latestPage,
    String latestSortBy,
    int latestYear,
  }) {
    return LoadedExplorerAnimes(
      animes: animes ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestSortBy: this.latestSortBy,
      latestYear: this.latestYear
    );
  }  
}

class ErrorExplorerAnimes extends AnimesExplorerState{
  final String message;
  ErrorExplorerAnimes({@required this.message});

  @override
  List<Object> get props => [message];
}
