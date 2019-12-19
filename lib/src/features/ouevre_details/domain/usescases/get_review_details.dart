

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/review_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/review_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetReviewDetails extends UseCase<List<ReviewEntity>, Params>{

    final ReviewDetailsContracts contract;
    
    GetReviewDetails(this.contract);

  @override
  Future<Either<Failures, List<ReviewEntity>>> call(Params params) async {
    
    return await contract.getReviews(params.id, params.type);
    
  }
}

class Params extends Equatable{
  final int id;
  final String type;

  Params({@required this.id, @required this.type}) : super([id, type]);
}