
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieExplorerContract{

  Future<Either<Failures, List<MovieEntity>>> getMoviesExplorer(
    int page,
  {
    String sortBy,
    int    year,
    int    voteCountGte,
    String genre,
    String withKeywords,
    String withOriginalLanguage,
    String withCompanies,
    String withWatchProvider
  });

}