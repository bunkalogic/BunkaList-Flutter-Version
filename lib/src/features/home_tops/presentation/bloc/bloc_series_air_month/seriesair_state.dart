part of 'seriesair_bloc.dart';

abstract class SeriesAirState extends Equatable {
  const SeriesAirState([List props = const <dynamic>[]]) : super(props);
}

class SeriesAirInitial extends SeriesAirState {}

class LoadingSeries extends SeriesAirState{}

class LoadedSeries extends SeriesAirState{
  final List<SeriesEntity> series;

  LoadedSeries({@required this.series}) : super([series]);
}

class ErrorSeries extends SeriesAirState{
  final String message;
  ErrorSeries({@required this.message}) : super([message]);
}
