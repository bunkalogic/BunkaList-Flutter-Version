

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/get_season_info_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetSeasonInfo extends UseCase<SeasonEntity, Params>{
  
  final SeasonInfoDetailsContract contract;

  GetSeasonInfo(this.contract);


  @override
  Future<Either<Failures, SeasonEntity>> call(Params params) async {
    
    return await contract.getSeasonInfo(params.id, params.seasonId);

  }

}

class Params extends Equatable{
  final int id;
  final int seasonId;

  Params({@required this.id, @required this.seasonId}) : super([id, seasonId]);
}