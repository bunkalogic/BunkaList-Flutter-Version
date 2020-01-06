

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_rs_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesDetailsRecommendationAndSimilarContracts{

  Future<Either<Failures, List<MovieEntityRS>>> getSimilarMovie(int id);

  Future<Either<Failures, List<MovieEntityRS>>> getRecommendationsMovie(int id);

}