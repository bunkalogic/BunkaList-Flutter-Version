

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SearchResultContract{

  Future<Either<Failures, ResultsEntity>> getSearch(String query, int page);
  
}