import 'package:bunkalist/src/features/ouevre_details/domain/entities/review_details_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends ReviewsState{}

class Loading extends ReviewsState{}

class Loaded extends ReviewsState{
  final List<ReviewEntity> reviews;
  Loaded({ @required this.reviews }) : super([reviews]);
}

class Error extends ReviewsState{
  final String message;
  Error({@required this.message}) : super ([message]);
}