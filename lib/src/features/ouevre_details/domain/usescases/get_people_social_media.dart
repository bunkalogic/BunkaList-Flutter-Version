
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_social_media_details_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_social_media_entity.dart';
import 'package:equatable/equatable.dart';

class GetPeopleSocialMedia extends UseCase<PeopleSocialMediaEntity, Params>{
  
  final PeopleSocialMediaContract contract;

  GetPeopleSocialMedia(this.contract);
  
  @override
  Future<Either<Failures, PeopleSocialMediaEntity>> call(Params params) async {
    return await contract.getPeopleSocialMedia(params.id);
  }

}

class Params extends Equatable{
  final int id;

  Params({@required this.id,}) : super([id]);
}