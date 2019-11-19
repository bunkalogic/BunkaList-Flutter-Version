

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetAnimeDetails extends UseCase<AnimeDetailsEntity, Params>{
  
  final AnimeDetailsContract contract;

  GetAnimeDetails(this.contract);
  
  @override
  Future<Either<Failures, AnimeDetailsEntity>> call(Params params) async {
    return await contract.getDetailsAnime(params.animeId);
  }

}

class Params extends Equatable {

final int animeId;

 Params ({ @required this.animeId }) : super([animeId]);

}