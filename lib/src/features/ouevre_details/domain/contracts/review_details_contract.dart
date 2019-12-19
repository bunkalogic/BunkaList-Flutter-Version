
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/review_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewDetailsContracts{

  Future<Either<Failures, List<ReviewEntity>>> getReviews(int id, String type);

}