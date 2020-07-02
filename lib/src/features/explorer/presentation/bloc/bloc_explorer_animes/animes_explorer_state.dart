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

     LoadedExplorerAnimes({
    this.animes,
    this.hasReachedMax,
    this.latestPage,
  }): super([animes, hasReachedMax, latestPage]);

  LoadedExplorerAnimes copyWith({
    List<AnimeEntity> animes,
    bool hasReachedMax,
    int latestPage,
  }) {
    return LoadedExplorerAnimes(
      animes: animes ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
    );
  }  
}

class ErrorExplorerAnimes extends AnimesExplorerState{
  final String message;
  ErrorExplorerAnimes({@required this.message});

  @override
  List<Object> get props => [message];
}
