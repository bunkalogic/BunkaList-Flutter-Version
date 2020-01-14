

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_details_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_details_entity.dart';
import 'package:equatable/equatable.dart';

class GetPeopleDetails extends UseCase<PeopleEntity, Params>{
  
  final PeopleDetailsContract contract;

  GetPeopleDetails(this.contract);
  
  @override
  Future<Either<Failures, PeopleEntity>> call(Params params) async {

    return contract.getPeopleDetails(params.id);    

  }

}

class Params extends Equatable{
  final int id;
 
  Params({@required this.id}) : super([id]);
}