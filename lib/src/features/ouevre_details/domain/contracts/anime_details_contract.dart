import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeDetailsContract {

  Future<Either<Failures, AnimeDetailsEntity>> getDetailsAnime(int id);

}