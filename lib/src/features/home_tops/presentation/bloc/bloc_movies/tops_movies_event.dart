import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsMoviesEvent extends Equatable {
  TopsMoviesEvent([List props = const <dynamic>[]]) : super(props);
}

class GetMoviesTops extends TopsMoviesEvent {
  final int topId;
  GetMoviesTops(this.topId) : super([topId]);
}

