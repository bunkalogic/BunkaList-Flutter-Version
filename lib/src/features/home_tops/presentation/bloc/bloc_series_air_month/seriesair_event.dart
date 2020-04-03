part of 'seriesair_bloc.dart';

abstract class SeriesAirEvent extends Equatable {
  const SeriesAirEvent([List props = const <dynamic>[]]) : super(props);
}

class GetSeriesAirInMonth extends SeriesAirEvent {
  final int topId;
  final int page;

  GetSeriesAirInMonth(this.topId, this.page) : super([topId, page]);
  
}