part of 'animeseason_bloc.dart';

abstract class AnimeSeasonState extends Equatable {
  const AnimeSeasonState([List props = const <dynamic>[]]) : super(props);
}

class AnimeSeasonInitial extends AnimeSeasonState {}

class LoadingAnimes extends AnimeSeasonState{}

class LoadedAnimes extends AnimeSeasonState{
  final List<AnimeEntity> animes;

  LoadedAnimes({@required this.animes}) : super([animes]);
}

class ErrorAnimes extends AnimeSeasonState{
  final String message;
  ErrorAnimes({@required this.message}) : super([message]);
}