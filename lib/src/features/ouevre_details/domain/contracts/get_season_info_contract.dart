

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SeasonInfoDetailsContract {

  Future<Either<Failures, SeasonEntity>> getSeasonInfo(int id, int seasonId);
  
}