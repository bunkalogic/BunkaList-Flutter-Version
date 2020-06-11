part of 'selectionseries_bloc.dart';

abstract class SelectionseriesEvent extends Equatable {
  const SelectionseriesEvent([List props = const <dynamic>[]]) : super(props);
}

class GetSelectionSeriesMonth extends SelectionseriesEvent {
  final int topId;
  final int page;

  GetSelectionSeriesMonth(this.topId, this.page) : super([topId, page]);
  
}
