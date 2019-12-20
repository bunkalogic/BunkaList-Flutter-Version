import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/credits_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CreditsDetailsContract{

  Future<Either<Failures, CreditsEntity>> getCredits(int id, String type);
}