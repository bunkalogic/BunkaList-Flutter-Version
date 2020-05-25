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
  final bool hasReachedMax;
  final int latestPage;
  final int latestTopId;

  LoadedSeries({
    this.series,
    this.hasReachedMax,
    this.latestPage,
    this.latestTopId
  }) : super([series, hasReachedMax, latestPage, latestTopId]);

  LoadedSeries copyWith({
    List<SeriesEntity> series,
    bool hasReachedMax,
    int latestPage,
    int latestTopId
  }) {
    return LoadedSeries(
      series: series ?? this.series,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestTopId: this.latestTopId
    );
  }  
}

class ErrorSeries extends TopsSeriesState{
  final String message;
  ErrorSeries({@required this.message}) : super([message]);
}

