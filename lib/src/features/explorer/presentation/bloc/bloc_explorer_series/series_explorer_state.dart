part of 'series_explorer_bloc.dart';

abstract class SeriesExplorerState extends Equatable {
  const SeriesExplorerState([List props = const []]) : super(props);
}

class SeriesExplorerInitial extends SeriesExplorerState {}

class SeriesExplorerLoading extends SeriesExplorerState {}

class LoadedExplorerSeries extends SeriesExplorerState{
  final List<SeriesEntity> series;
  final bool hasReachedMax;
  final int latestPage;
  final String latestSortBy;
  final int latestYear;

     LoadedExplorerSeries({
    this.series,
    this.hasReachedMax,
    this.latestPage,
    this.latestSortBy,
    this.latestYear
  }): super([series, hasReachedMax, latestPage, latestSortBy, latestYear]);

  LoadedExplorerSeries copyWith({
    List<SeriesEntity> series,
    bool hasReachedMax,
    int latestPage,
    String latestSortBy,
    int latestYear,
  }) {
    return LoadedExplorerSeries(
      series: series ?? this.series,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestSortBy: this.latestSortBy,
      latestYear: this.latestYear
    );
  }  
}

class ErrorExplorerSeries extends SeriesExplorerState{
  final String message;
  ErrorExplorerSeries({@required this.message});

  @override
  List<Object> get props => [message];
}
