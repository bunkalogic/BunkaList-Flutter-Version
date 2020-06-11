part of 'selectionanimes_bloc.dart';

abstract class SelectionanimesState extends Equatable {
  const SelectionanimesState([List props = const <dynamic>[]]) : super(props);
}

class SelectionanimesInitial extends SelectionanimesState {}

class LoadingSelectionanimesBlocAnimes extends SelectionanimesState{}

class LoadedSelectionanimesBlocAnimes extends SelectionanimesState{
  final List<AnimeEntity> animes;

  LoadedSelectionanimesBlocAnimes({@required this.animes}) : super([animes]);
}

class ErrorSelectionanimesBlocAnimes extends SelectionanimesState{
  final String message;
  ErrorSelectionanimesBlocAnimes({@required this.message}) : super([message]);
}
