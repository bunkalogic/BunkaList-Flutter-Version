
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PeopleDetailsContract{

  Future<Either<Failures, PeopleEntity>> getPeopleDetails(int id);

}