import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details.rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_rs_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetAnimeSimilar extends UseCase<List<AnimeEntityRS>, Params>{

  final AnimeDetailsRecommendationAndSimilarContracts contracts;

  GetAnimeSimilar(this.contracts);



  @override
  Future<Either<Failures, List<AnimeEntityRS>>> call(params) async{
    return await contracts.getSimilarAnime(params.id);
  }

}

class Params extends Equatable {

final int id;

 Params ({ @required this.id }) : super([id]);

}