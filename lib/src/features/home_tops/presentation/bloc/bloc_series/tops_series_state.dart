import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsSeriesState extends Equatable {
TopsSeriesState([List props = const <dynamic>[]]) : super(props);
}

class EmptySeries extends TopsSeriesState{}

class LoadingSeries extends TopsSeriesState{}

class LoadedSeries extends TopsSeriesState{
  final List<SeriesEntity> series;

  LoadedSeries({@required this.series}) : super([series]);
}

class ErrorSeries extends TopsSeriesState{
  final String message;
  ErrorSeries({@required this.message}) : super([message]);
}

