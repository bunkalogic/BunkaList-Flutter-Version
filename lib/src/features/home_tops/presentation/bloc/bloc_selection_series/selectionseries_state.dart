part of 'selectionseries_bloc.dart';

abstract class SelectionseriesState extends Equatable {
  const SelectionseriesState([List props = const <dynamic>[]]) : super(props);
}

class SelectionseriesInitial extends SelectionseriesState {}

class LoadingSelectionSeries extends SelectionseriesState{}

class LoadedSelectionSeries extends SelectionseriesState{
  final List<SeriesEntity> series;

  LoadedSelectionSeries({@required this.series}) : super([series]);
}

class ErrorSelectionSeries extends SelectionseriesState{
  final String message;
  ErrorSelectionSeries({@required this.message}) : super([message]);
}

