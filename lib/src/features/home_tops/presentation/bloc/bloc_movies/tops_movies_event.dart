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

class GetMoviesTopsPopular extends TopsMoviesEvent {
  final int topId;
  GetMoviesTopsPopular(this.topId) : super([topId]);
}

class GetMoviesTopsRated extends TopsMoviesEvent {
  final int topId;
  GetMoviesTopsRated(this.topId) : super([topId]);
}

class GetMoviesTopsUpcoming extends TopsMoviesEvent {
  final int topId;
  GetMoviesTopsUpcoming(this.topId) : super([topId]);
}









