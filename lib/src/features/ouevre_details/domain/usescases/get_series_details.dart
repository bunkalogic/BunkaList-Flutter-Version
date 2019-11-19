
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetSerieDetails extends UseCase<SerieDetailsEntity, Params>{
  
  final SerieDetailsContract contract;

  GetSerieDetails(this.contract);
  
  @override
  Future<Either<Failures, SerieDetailsEntity>> call(Params params) async {
    return await contract.getDetailsSerie(params.serieId);
  }

}

class Params extends Equatable {

final int serieId;

 Params ({ @required this.serieId }) : super([serieId]);

}