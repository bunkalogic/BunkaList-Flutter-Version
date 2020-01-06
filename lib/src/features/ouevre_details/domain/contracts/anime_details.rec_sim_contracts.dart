import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_rs_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeDetailsRecommendationAndSimilarContracts{

  Future<Either<Failures, List<AnimeEntityRS>>> getSimilarAnime(int id);

  Future<Either<Failures, List<AnimeEntityRS>>> getRecommendationsAnime(int id);

}