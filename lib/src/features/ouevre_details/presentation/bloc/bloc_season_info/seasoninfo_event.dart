import 'package:equatable/equatable.dart';

abstract class SeasonInfoEvent extends Equatable {
  const SeasonInfoEvent([List props = const <dynamic>[]]) : super (props);
}

class GetInfoSeason extends SeasonInfoEvent{

  final int id;
  final int seasonId;

  GetInfoSeason(this.id, this.seasonId) : super ([id, seasonId]);
}
