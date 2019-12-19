import 'package:equatable/equatable.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent([List props = const <dynamic>[]]) : super (props);
}

class GetDetailsReviews extends ReviewsEvent{

  final int id;
  final String type;
  GetDetailsReviews(this.id, this.type) : super ([id, type]);
}
