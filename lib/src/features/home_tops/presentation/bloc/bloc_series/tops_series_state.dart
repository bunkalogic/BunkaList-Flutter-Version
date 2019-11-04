import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsSeriesState extends Equatable {
TopsSeriesState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends TopsSeriesState{}

class Loading extends TopsSeriesState{}

class Loaded extends TopsSeriesState{
  final List<SeriesEntity> series;

  Loaded({@required this.series}) : super([series]);
}

class Error extends TopsSeriesState{
  final String message;
  Error({@required this.message}) : super([message]);
}

