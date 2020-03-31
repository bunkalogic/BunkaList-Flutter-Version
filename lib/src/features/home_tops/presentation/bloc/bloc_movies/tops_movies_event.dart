import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsMoviesEvent extends Equatable {
  TopsMoviesEvent([List props = const <dynamic>[]]) : super(props);
}

class GetMoviesTops extends TopsMoviesEvent {
  final int topId;
  final int page;
  GetMoviesTops(this.topId, this.page) : super([topId, page]);
}











