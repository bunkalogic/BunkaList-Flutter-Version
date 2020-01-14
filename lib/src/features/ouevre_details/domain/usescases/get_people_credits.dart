import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_credits_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_credits_entity.dart';
import 'package:equatable/equatable.dart';

class GetPeopleCredits extends  UseCase<PeopleCreditsEntity, Params>{

  final PeopleCreditsContract contract;

  GetPeopleCredits(this.contract);


  @override
  Future<Either<Failures, PeopleCreditsEntity>> call(Params params) async {
    
    return await contract.getPeopleCredits(params.id);
    
  }

}

class Params extends Equatable{
  final int id;

  Params({@required this.id}) : super([id]);
}