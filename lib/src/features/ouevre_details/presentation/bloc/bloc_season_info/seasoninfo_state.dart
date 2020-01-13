import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SeasonInfoState extends Equatable {
  const SeasonInfoState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends SeasonInfoState{}

class Loading extends SeasonInfoState{}

class Loaded extends SeasonInfoState{
  final List<EpisodeEntity> episode;
  Loaded({ @required this.episode }) : super([episode]);
}

class Error extends SeasonInfoState{
  final String message;
  Error({@required this.message}) : super ([message]);
}