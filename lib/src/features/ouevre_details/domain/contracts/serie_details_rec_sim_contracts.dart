import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_rs_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SeriesDetailsRecommendationAndSimilarContracts{

  Future<Either<Failures, List<SeriesEntityRS>>> getSimilarSeries(int id);

  Future<Either<Failures, List<SeriesEntityRS>>> getRecommendationsSeries(int id);

}