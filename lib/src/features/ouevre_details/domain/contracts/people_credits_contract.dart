

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_credits_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PeopleCreditsContract{

  Future<Either<Failures, PeopleCreditsEntity>> getPeopleCredits(int id);
  
}