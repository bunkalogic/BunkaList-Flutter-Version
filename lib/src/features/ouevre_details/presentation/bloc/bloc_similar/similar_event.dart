import 'package:equatable/equatable.dart';

abstract class SimilarEvent extends Equatable {
  const SimilarEvent([List props = const <dynamic>[]]) : super (props);

}

class GetSimilar extends SimilarEvent {
  
  final int id;
  final String type;
  GetSimilar(this.id, this.type) : super ([id, type]);

}
