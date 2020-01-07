import 'package:equatable/equatable.dart';

abstract class RecomAndSimilarEvent extends Equatable {

  RecomAndSimilarEvent([List props = const <dynamic>[]]) : super (props);

}

class GetRecommendations extends RecomAndSimilarEvent {

  final int id;
  final String type;
  GetRecommendations(this.id, this.type) : super ([id, type]);

}


class GetSimilar extends RecomAndSimilarEvent {
  
  final int id;
  final String type;
  GetSimilar(this.id, this.type) : super ([id, type]);

}


