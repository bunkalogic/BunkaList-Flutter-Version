

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SeriePersonalTopsContract{

  Future<Either<Failures, List<SeriesEntity>>> getSeriesPersonalTops(
    int page,
  {
    String sortBy,
    int year,
    int voteCountGte,
    String genre,
    String withNetwork,
    String withKeywords,
    String withOriginalLanguage
  });

}