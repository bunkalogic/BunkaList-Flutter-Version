import 'package:equatable/equatable.dart';

abstract class RecommendationsEvent extends Equatable {
  
  RecommendationsEvent([List props = const <dynamic>[]]) : super (props);

}


class GetRecommendations extends RecommendationsEvent {

  final int id;
  final String type;
  GetRecommendations(this.id, this.type) : super ([id, type]);

}