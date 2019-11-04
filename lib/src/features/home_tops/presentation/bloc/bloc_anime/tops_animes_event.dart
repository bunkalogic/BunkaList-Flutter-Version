import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsAnimesEvent extends Equatable {
  TopsAnimesEvent([List props = const <dynamic>[]]) : super(props);
}

class GetAnimesTops extends TopsAnimesEvent {
  final int topId;
  GetAnimesTops(this.topId) : super([topId]);
}
