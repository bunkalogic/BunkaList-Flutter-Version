import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsAnimesState extends Equatable {
TopsAnimesState([List props = const <dynamic>[]]) : super(props);
}

class EmptyAnimes extends TopsAnimesState{}

class LoadingAnimes extends TopsAnimesState{}

class LoadedAnimes extends TopsAnimesState{
  final List<AnimeEntity> animes;

  LoadedAnimes({@required this.animes}) : super([animes]);
}

class ErrorAnimes extends TopsAnimesState{
  final String message;
  ErrorAnimes({@required this.message}) : super([message]);
}
