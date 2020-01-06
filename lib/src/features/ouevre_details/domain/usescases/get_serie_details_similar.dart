import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_rs_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetSeriesSimilar extends UseCase<List<SeriesEntityRS>, Params>{

  final SeriesDetailsRecommendationAndSimilarContracts contracts;

  GetSeriesSimilar(this.contracts);



  @override
  Future<Either<Failures, List<SeriesEntityRS>>> call(params) async{
    return await contracts.getSimilarSeries(params.id);
  }

}

class Params extends Equatable {

final int id;

 Params ({ @required this.id }) : super([id]);

}