import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/credits_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/credits_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class GetCreditsDetails extends UseCase<CreditsEntity, Params>{
  
  final CreditsDetailsContract contract;

  GetCreditsDetails(this.contract);


  @override
  Future<Either<Failures, CreditsEntity>> call(params) async {
    return await contract.getCredits(params.id, params.type);
  }

}

class Params extends Equatable{
  final int id;
  final String type;

  Params({@required this.id, @required this.type}) : super([id, type]);
}