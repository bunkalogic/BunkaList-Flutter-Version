import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsSeriesEvent extends Equatable {
  TopsSeriesEvent([List props = const <dynamic>[]]) : super(props);
}

class GetSeriesTops extends TopsSeriesEvent {
  final int topId;
  final int page;
  GetSeriesTops(this.topId, this.page) : super([topId, page]);
}
