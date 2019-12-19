import 'dart:async';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/review_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_review_details.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  
  final GetReviewDetails getReviewDetails;

  ReviewsBloc({
    @required GetReviewDetails reviews
  }) 
  : assert(reviews != null),
    getReviewDetails = reviews;
  
  
  
  @override
  ReviewsState get initialState => Empty();

  @override
  Stream<ReviewsState> mapEventToState(
    ReviewsEvent event,
  ) async* {

    if(event is GetDetailsReviews){
      final inputEither = GetTopId().getValidateTopId(event.id);
      final String type = event.type;

      yield* inputEither.fold(
        (failures) async* {
          
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);

      }, (id) async*{

        yield Loading();

        final failureOrReview = await getReviewDetails(Params(id: id, type: type));

        yield* _eitherLoadedOrErrorState(failureOrReview);

      });
    }
  }

  Stream<ReviewsState> _eitherLoadedOrErrorState
  (Either<Failures, List<ReviewEntity>> either) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)), 
      (reviews)  => Loaded(reviews: reviews)
    );
  }
  
  String _mapFailureToMessage(Failures failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
