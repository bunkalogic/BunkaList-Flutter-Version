
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeExplorerContract{

  Future<Either<Failures, List<AnimeEntity>>> getAnimeExplorer(
    int page,
  {
    String sortBy,
    int year,
    int voteCountGte,
    String genre,
    String withNetwork,
    String withKeywords,
  });

}