import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsAnimesState extends Equatable {
TopsAnimesState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TopsAnimesState{}

class Loading extends TopsAnimesState{}

class Loaded extends TopsAnimesState{
  final List<AnimeEntity> animes;

  Loaded({@required this.animes}) : super([animes]);
}

class Error extends TopsAnimesState{
  final String message;
  Error({@required this.message}) : super([message]);
}
